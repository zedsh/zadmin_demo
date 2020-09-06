<?php


namespace App\Admin\Fields;


use Carbon\Carbon;

class DateField extends BaseField
{
    protected $template = 'admin.blade.fields.date';
    protected $dateFormat = "d.m.Y";


    public function setDateFormat($format)
    {
        $this->dateFormat = $format;
    }

    public function getDateFormat()
    {
        return $this->dateFormat;
    }

    public function getValue()
    {
        $date = $this->model->{$this->getName()};
        if(empty($date)) {
            $date = new Carbon();
        }
        return $date->format($this->getDateFormat());
    }


}
