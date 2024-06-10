module TurboEditable

  module IconsHelper

    def editable_check_icon
      return editable_icon("fa fa-check") if TurboEditable.configuration.icons_framework == :fa
      return editable_icon("bi bi-check-lg") if TurboEditable.configuration.icons_framework == :bi
    end

    def editable_save_icon
      return editable_icon("fa fa-check") if TurboEditable.configuration.icons_framework == :fa
      return editable_icon("bi bi-floppy") if TurboEditable.configuration.icons_framework == :bi
    end

    def editable_x_icon
      return editable_icon("fa fa-times") if TurboEditable.configuration.icons_framework == :fa
      return editable_icon("bi bi-x-lg") if TurboEditable.configuration.icons_framework == :bi
    end

    def editable_pen_icon
      return editable_icon("fa fa-pen text-black") if TurboEditable.configuration.icons_framework == :fa
      return editable_icon("bi bi-pen text-black") if TurboEditable.configuration.icons_framework == :bi
    end

    def editable_trash_icon
      return editable_icon("fa fa-trash text-black") if TurboEditable.configuration.icons_framework == :fa
      return editable_icon("bi bi-trash text-black") if TurboEditable.configuration.icons_framework == :bi
    end

    def editable_icon c
      return content_tag(:i, "", class: c)
    end

  end

end