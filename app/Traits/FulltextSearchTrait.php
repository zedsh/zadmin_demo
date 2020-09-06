<?php


namespace App\Traits;

/**
 * Trait FulltextSearchTrait
 * @package App\Traits
 * @method fulltextSearch($field, $value)
 */
trait FulltextSearchTrait
{
    public function scopeFulltextSearch($query, $field, $value)
    {
        $prepared = $value;
        $prepared = preg_replace('/[^\p{L}\p{N}_]+/u', ' ', $prepared);
        $prepared = preg_replace('/[+\-><\(\)~*\"@]+/', ' ', $prepared);
        $query->whereRaw('MATCH(' . $this->getTable() . '.' . $field . ') AGAINST(? IN BOOLEAN MODE)', "$prepared*");
        return $query;
    }

}
