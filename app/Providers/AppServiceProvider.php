<?php

namespace App\Providers;

use App\Admin\Actions\EditSocialsAction;
use App\Artist;
use App\Organizer;
use App\Place;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\Relation;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Pagination\Paginator;
use Illuminate\Support\Collection;
use Illuminate\Support\ServiceProvider;
use TCG\Voyager\Facades\Voyager;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        Relation::morphMap([
            'organizers' => Organizer::class,
            'places' => Place::class,
            'artists' => Artist::class,
        ]);

        if (!Collection::hasMacro('paginate')) {

            Collection::macro('paginate',
                function ($perPage = 15, $page = null, $options = []) {
                    $page = $page ?: (Paginator::resolveCurrentPage() ?: 1);
                    return (new LengthAwarePaginator(
                        $this->forPage($page, $perPage)->values()->all(), $this->count(), $perPage, $page, $options))
                        ->withPath('');
                });

            Collection::macro('loadModels',
                function () {
                    $objects = collect([]);

                    $classes =$this->groupBy(function ($item, $key) {
                        if($item instanceof Model){
                            return get_class($item);//::class;
                        } else {
                            return null;
                        }
                    });
                    $classList = $classes->keys();
                    foreach ($classList as $class) {
                        if(empty($class)) {
                            continue;
                        }
                        $items = $class::whereIn('id', $classes[$class]->pluck('id')->toArray())->get();
                        $objects = $objects->merge($classes[$class]->map(function($item) use ($items) {
                            return $items->where('id',$item->id)->first();
                        }));
                    }
                    $this->transform(function($original, $id) use ($objects) {
                        return $objects[$id];
                    });

                    return $this;
                });
        }

    }
}
