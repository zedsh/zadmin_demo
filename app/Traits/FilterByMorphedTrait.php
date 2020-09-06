<?php


namespace App\Traits;


use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\MorphToMany;

trait FilterByMorphedTrait
{
    public function scopeFilterByMorphed(Builder $query, $relation, $filterClosure)
    {
        $relationObject = $this->{$relation}();
        /**
         * @var MorphToMany $relationObject
         */

        $intermediateTable = $relationObject->getTable();
        $intermediateForeign = $relationObject->getForeignPivotKeyName();
        $intermediateForeignType = $relationObject->getMorphType();
        $intermediateForeignTypeValue = $relationObject->getMorphClass();
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
                $intermediateForeignType,
                $intermediateForeignTypeValue,
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
                $parentKey,
                $intermediateForeignType,
                $intermediateForeignTypeValue
            ) {
                $join->on("$intermediateTable.$intermediateForeign", '=',
                    "$parentTable.$parentKey")->where("$intermediateTable.$intermediateForeignType", '=',
                    $intermediateForeignTypeValue);
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
