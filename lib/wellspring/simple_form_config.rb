require 'simple_form'

SimpleForm.setup do |config|
  config.button_class = 'btn btn-primary'
  config.boolean_label_class = nil

  config.wrappers :horizontal_form, tag: 'div', class: 'row space-bottom-2', error_class: 'invalid' do |b|
    b.use :html5
    b.use :placeholder

    b.use :label #, class: 'col-3'

    b.wrapper tag: 'div', class: 'input' do |ba|
      ba.use :hint,  wrap_with: { tag: 'div', class: 'text-muted hint' }
      ba.use :input, wrap_with: { error_class: 'invalid' }
      ba.use :error, wrap_with: { tag: 'label', class: 'error' }
    end
  end

  config.default_wrapper = :horizontal_form
end
