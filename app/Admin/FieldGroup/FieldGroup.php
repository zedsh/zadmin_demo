<?php
namespace App\Admin\FieldGroup;



class FieldGroup
{

    protected $title;
    protected $model;
    protected $fields = [];
    protected $template = 'admin.fieldgroup.fieldgroup'; //вместо / в ларавель используются точки (для шаблонов так)

    public function __construct($title, $fields = [])
    {
        $this->title = $title;
        $this->fields = $fields;
    }


    public function getTitle()
    {
        return $this->title;
    }

    public function setModel($model)
    {
        $this->model = $model;

        return $this;
    }


    public function render()
    {
        $content = '';

        foreach ($this->fields as $field) {
            $content .= $field->setModel($this->model)->render();
        }

        return view($this->template, ['content' => $content, 'formGroup' => $this]);
    }
}