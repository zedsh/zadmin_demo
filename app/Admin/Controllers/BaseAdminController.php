<?php


namespace App\Admin\Controllers;

use App\Admin\Templates\BaseTemplate;
use App\Http\Controllers\Controller;


class BaseAdminController extends Controller
{
    protected $template;

    protected function getTemplate()
    {
        return (new BaseTemplate());
    }

}
