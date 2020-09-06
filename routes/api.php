<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::resource('artists', 'ArtistController')->only(['index','show']);
Route::resource('organizers', 'OrganizerController')->only(['index','show']);
Route::resource('regions', 'RegionsController')->only(['index','show']);
Route::resource('artist_types', 'ArtistTypeController')->only(['index','show']);
Route::resource('main_banner', 'MainBannerController')->only(['index']);
Route::resource('events', 'EasyEventController')->only(['index']);
Route::resource('features', 'FeatureController')->only(['index','show']);
Route::resource('places', 'PlaceController')->only(['index','show']);
Route::resource('search', 'SearchController')->only(['index']);
Route::resource('form_search', 'FormSearchController')->only(['index']);
Route::resource('geo_ip', 'GeoIpController')->only(['index']);
Route::resource('subscribe', 'SubscribeController')->only(['store']);
