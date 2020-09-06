<?php


namespace App\Admin\Fields;


class TextField extends BaseField
{
    protected $template = 'admin.blade.fields.text';
    protected $slugFrom;

    public function setSlugFrom($name)
    {
        $this->slugFrom = $name;
        return $this;
    }

    public function getSlugFrom()
    {
        return $this->slugFrom;
    }



}
