<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

Auth::routes(['register' => false, 'reset' => false, 'verify' => false]);


Route::namespace('Admin')->prefix('/admin')->middleware('auth')->group(function () {
    Route::get('/',function () {
        return redirect(route('user.list'));
    });

    Route::prefix('/user')->name('user.')->group(function () {
        $controller = 'UserController@';
        Route::get('/edit/{id}', $controller . 'edit')->name('edit');
        Route::get('/add', $controller . 'add')->name('add');
        Route::post('/save',  $controller . 'save')->name('save');
        Route::get('/delete/{id}', $controller . 'delete')->name('delete');
        Route::get('/list', $controller . 'list')->name('list');
    });

});
