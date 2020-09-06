<?php


namespace App\Http\Controllers\Admin;


use App\Admin\Controllers\BaseAdminController;
use App\Admin\Templates\ProjectTemplate;

class AdminController extends BaseAdminController
{
    protected function render($renderable)
    {
        return ProjectTemplate::renderView($renderable);
    }

}
