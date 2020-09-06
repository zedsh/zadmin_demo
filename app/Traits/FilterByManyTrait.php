<?php


namespace App\Traits;


use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\MorphToMany;

trait FilterByManyTrait
{
    public function scopeFilterBelongsToMany(Builder $query, $relation, $filterClosure)
    {
        $relationObject = $this->{$relation}();
        /**
         * @var BelongsToMany $relationObject
         */

        $intermediateTable = $relationObject->getTable();
        $intermediateForeign = $relationObject->getForeignPivotKeyName();
        $intermediateRelatedKey = $relationObject->getRelatedPivotKeyName();

        $relatedTable = $relationObject->getRelated()->getTable();
        $relatedKey = $relationObject->getRelatedKeyName();

        $parentTable = $relationObject->getParent()->getTable();
        $parentKey = $relationObject->getParentKeyName();

        $query->whereIn('id', function ($query) use (
               $intermediateTable,
                $relatedTable,
                $intermediateForeign,
                $parentTable,
                $parentKey,
                $intermediateRelatedKey,
                $relatedKey,
                $filterClosure
        ) {
            $query->select("$parentTable.$parentKey")
                ->from($parentTable)
                ->join($intermediateTable, function ($join) use (
                $intermediateTable,
                $intermediateForeign,
                $parentTable,
                $parentKey
            ) {
                $join->on("$intermediateTable.$intermediateForeign", '=',
                    "$parentTable.$parentKey");
            });

            $query->join($relatedTable, function ($join) use (
                $intermediateTable,
                $intermediateRelatedKey,
                $relatedTable,
                $relatedKey
            ) {
                $join->on("$intermediateTable.$intermediateRelatedKey", '=', "$relatedTable.$relatedKey");
            });

            $filterClosure($query);
        });
    }

}
