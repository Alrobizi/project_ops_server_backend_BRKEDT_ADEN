<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return redirect('/app/');
});

Route::get('/app/{any?}', function () {
    $indexPath = public_path('app/index.html');
    if (file_exists($indexPath)) {
        return response()->file($indexPath, [
            'Cache-Control' => 'no-cache, no-store, must-revalidate',
        ]);
    }
    return view('welcome');
})->where('any', '.*');


