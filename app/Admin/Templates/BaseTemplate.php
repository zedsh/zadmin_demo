<?php


namespace App\Admin\Templates;


use App\Admin\Forms\BaseForm;
use App\Admin\Menu\BaseMenu;

class BaseTemplate
{
    protected $template = 'admin.blade.layouts.admin';
    protected $content;
    protected $menu;

    public function setTemplate($path)
    {
        $this->template = $path;
        return $this;
    }

    public function setMenu(BaseMenu $menu)
    {
        $this->menu = $menu;
        return $this;
    }

    public function getMenu()
    {
        return $this->menu;
    }

    public function setContent($content)
    {
        $this->content = $content;
        return $this;
    }

    public function getView()
    {
        return view($this->template, ['content' => $this->content, 'menu' => $this->getMenu()->render() ]);
    }

    public static function renderView($form)
    {
        return (new static())->setContent($form->render())->getView();
    }
}
