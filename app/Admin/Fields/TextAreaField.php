<?php


namespace App\Admin\Fields;


class TextAreaField extends BaseField
{
    protected $maxLength = null;
    protected $template = 'admin.blade.fields.textArea';

    public function getMaxLength()
    {
        return $this->maxLength;
    }

    public function setMaxLength($maxLength)
    {
        $this->maxLength = $maxLength;
        return $this;
    }

}
