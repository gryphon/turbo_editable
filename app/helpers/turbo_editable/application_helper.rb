module TurboEditable
  module ApplicationHelper

    # This is element wrapper for form
    def editable_input model, field, **params

      namespace = params[:namespace] || (controller.class.module_parent == Object) ? nil : controller.class.module_parent.to_s.underscore.to_sym

      params[:cancel_url] = [namespace, model].flatten if params[:cancel_url].nil?

      model = model.last if model.kind_of?(Array)

      render "turbo_editable/editable_input", model: model, field: field, **params do
        yield
      end
    end

    # Generic editable field. Suitable for any type
    def editable_field model, field, **params
      # params[:url] = root_path
      namespace = params[:namespace] || (controller.class.module_parent == Object) ? nil : controller.class.module_parent.to_s.underscore.to_sym
      params[:disabled] = ActiveModel::Type::Boolean.new.cast(params[:disabled])

      if params[:url].nil? && !namespace.nil?
        params[:url] = [namespace, model].flatten
      end

      params[:edit_url] = [params[:form_action].presence || :edit, namespace, model, editable: true].flatten if params[:edit_url].nil?

      if params[:url].nil? && !namespace.nil?
        params[:url] = [namespace, model]
      end

      model = model.last if model.kind_of?(Array)

      render "turbo_editable/editable", model: model, field: field, **params do
        yield
      end
    end

    # Automatically decides which editable to use
    def editable model, field, **params

      inst = model.kind_of?(Array) ? model.last : model

      if !inst.class.columns.find{|f| f.name == field && f.type == "boolean"}.nil?
        return editable_boolean(model, field) { yield }
      end
      return editable_field(model, field, **params) { yield }
    end

    # Editable field for boolean values ("Switch")
    def editable_boolean model, field
      render "turbo_editable/editable_boolean", model: model, field: field do
        yield
      end
    end

    def editable_validation_errors(model, field)
      if (e = model.errors.messages.select{|k,v| k.to_s != field.to_s}).length > 0
        content_tag(:div, e.collect{|k,v| "#{model.class.human_attribute_name(k)}: #{v.join(", ")}"}.join(", "), class: "invalid-feedback d-block")
      end
    end

  end
end
