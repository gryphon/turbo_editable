module TurboEditableHelper

  def editable_input model, field, **params
    params[:back_url] = model if params[:back_url].nil?
    model = model.last if model.kind_of?(Array)
    render "turbo_editable/editable_input", model: model, field: field, **params do
      yield
    end
  end

  def editable model, field, **params

    params[:url] = model if params[:url].nil?
    params[:edit_url] = [params[:form_action].presence || :edit, model, editable: true].flatten if params[:edit_url].nil?

    model = model.last if model.kind_of?(Array)

    render "turbo_editable/editable", model: model, field: field, **params do
      yield
    end
  end

  def editable_boolean model, field, **params

    params[:url] = model if params[:url].nil?

    model = model.last if model.kind_of?(Array)

    render "turbo_editable/editable_boolean", model: model, field: field, **params do
      yield
    end
  end

  def editable_validation_errors(model, field)
    if (e = model.errors.messages.select{|k,v| k.to_s != field.to_s}).length > 0
      content_tag(:div, e.collect{|k,v| "#{model.class.human_attribute_name(k)}: #{v.join(", ")}"}.join(", "), class: "invalid-feedback d-block")
    end
  end

end
