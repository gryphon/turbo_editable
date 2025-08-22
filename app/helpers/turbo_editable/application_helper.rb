module TurboEditable
  module ApplicationHelper

    # This is element wrapper for form
    def editable_input model, field, **options, &block

      content = capture(&block)

      namespace = options[:namespace] || (controller.class.module_parent == Object) ? nil : controller.class.module_parent.to_s.underscore.to_sym

      options[:cancel_url] = params[:cancel_url].blank? ? [namespace, model].flatten : params[:cancel_url] 

      model = model.last if model.kind_of?(Array)

      render "turbo_editable/editable_input", model: model, field: field, **options do
        content
      end
    end

    # Generic editable field. Suitable for any type
    def editable_field model, field, **params, &block

      content = capture(&block)

      # params[:url] = root_path
      namespace = params[:namespace] || (controller.class.module_parent == Object) ? nil : controller.class.module_parent.to_s.underscore.to_sym
      params[:disabled] = ActiveModel::Type::Boolean.new.cast(params[:disabled])
      params[:disabled] = !ActiveModel::Type::Boolean.new.cast(params[:if]) if !params[:if].nil?
      params[:mode] ||= TurboEditable.configuration.mode

      if params[:url].nil?
        params[:url] = [namespace, model].flatten
      end

      params[:display] = "inline-block" if params[:display].nil?

      if params[:edit_url].nil?
        params[:edit_url] = [params[:form_action].presence || :edit, namespace, model, editable: field, cancel_url: params[:cancel_url]].flatten
      else
        parsed_url = URI.parse(params[:edit_url])
        query_hash = Rack::Utils.parse_query(parsed_url.query)
        query_hash["editable"] = field if query_hash["editable"].blank?
        query_hash["cancel_url"] = params[:cancel_url] if query_hash["cancel_url"].blank?
        parsed_url.query = Rack::Utils.build_query(query_hash)
        params[:edit_url] = parsed_url.to_s
      end

      model = model.last if model.kind_of?(Array)

      render "turbo_editable/editable", model: model, field: field, **params do
        content
      end
    end

    def editable_frame_id model, field
      dom_id(model, "#{field}_frame")
    end

    # Automatically decides which editable to use
    def editable model, field, **params, &block

      content = capture(&block)

      inst = model.kind_of?(Array) ? model.last : model

      params[:type] = "boolean" if params[:type].nil? && !inst.class.columns.find{|f| f.name.to_s == field.to_s && f.type.to_s == "boolean"}.nil?

      if params[:type] == "boolean"
        return editable_boolean(model, field, **params) { content }
      end
      if params[:type] == "approved"
        return editable_approved(model, field, **params) { content }
      end
      return editable_field(model, field, **params) { content }
    end

    # Editable field for boolean values ("Switch")
    def editable_boolean model, field, **params, &block

      content = capture(&block)

      namespace = params[:namespace] || (controller.class.module_parent == Object) ? nil : controller.class.module_parent.to_s.underscore.to_sym
      params[:disabled] = ActiveModel::Type::Boolean.new.cast(params[:disabled])
      params[:disabled] = !ActiveModel::Type::Boolean.new.cast(params[:if]) if !params[:if].nil?

      if params[:url].nil?
        params[:url] = [namespace, model].flatten
      end

      params[:edit_url] = [params[:form_action].presence || :edit, namespace, model, editable: field].flatten if params[:edit_url].nil?

      render "turbo_editable/editable_boolean", model: model, field: field, **params do
        content
      end
    end

    # Editable field for approved values (to pass current user approvement)
    # Params:
    # - form_action - action for rendering form ("edit" by default)
    # - update_action - action for updating record ("update" by default)

    def editable_approved model, field, **params, &block

      content = capture(&block) if block_given?

      namespace = params[:namespace] || (controller.class.module_parent == Object) ? nil : controller.class.module_parent.to_s.underscore.to_sym
      params[:disabled] = ActiveModel::Type::Boolean.new.cast(params[:disabled])
      params[:disabled] = !ActiveModel::Type::Boolean.new.cast(params[:if]) if !params[:if].nil?
      params[:update_action] ||= :update

      if params[:url].nil?
        params[:url] = [(params[:update_action].to_s == "update" ? nil : params[:update_action]), namespace, model].flatten      
      end

      params[:edit_url] = [params[:form_action].presence || :edit, namespace, model, editable: field].flatten if params[:edit_url].nil?

      model = model.last if model.kind_of?(Array)

      render "turbo_editable/editable_approved", model: model, field: field, **params do
        content if block_given?
      end
    end

    def editable_validation_errors(model, field)
      if (e = model.errors.messages.select{|k,v| k.to_s != field.to_s}).length > 0
        content_tag(:div, e.collect{|k,v| "#{model.class.human_attribute_name(k)}: #{v.join(", ")}"}.join(", "), class: "invalid-feedback d-block")
      end
    end

    def editable_switch **params
      if !params[:target]
        params[:target] = ""
      else
        if params[:target] == "modal"
          params[:target] = "closest('.modal-content')" 
        else
          params[:target] = "document.getElementById('#{params[:target]}')"
        end
      end
      render "turbo_editable/editable_switch", **params
    end

    def custom_editable_buttons
      if !params[:editable].blank?
        render "turbo_editable/custom_editable_buttons"
      end
    end

  end
end
