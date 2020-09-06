<?php


namespace App\Admin\Filters;


class FulltextFilter extends BaseFilter
{
    protected function filter($query, $value)
    {
        $query->fulltextSearch($this->field, $value);
    }
}
