module TurboEditableHelper

  def editable_input model, field, **params

    namespace = params[:namespace] || (controller.class.module_parent == Object) ? nil : controller.class.module_parent.to_s.underscore.to_sym

    params[:cancel_url] = [namespace, model]

    render "turbo_editable/editable_input", model: model, field: field, **params do
      yield
    end
  end

  def editable model, field, **params
    # params[:url] = root_path
    namespace = params[:namespace] || (controller.class.module_parent == Object) ? nil : controller.class.module_parent.to_s.underscore.to_sym
    params[:disabled] = ActiveModel::Type::Boolean.new.cast(params[:disabled])

    if params[:url].nil? && !namespace.nil?
      params[:url] = [namespace, model]
    end

    params[:edit_url] = [params[:form_action].presence || :edit, namespace, model, editable: true]

    if params[:url].nil? && !namespace.nil?
      params[:url] = [namespace, model]
    end
 
    render "turbo_editable/editable", model: model, field: field, **params do
      yield
    end
  end

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
