<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateStatusTracksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('status_tracks', function (Blueprint $table) {
            $table->id();
            $table->string('uid')->index('uid');//Uid
            $table->string('uidUser')->default('none')->index('uidUser');//User Who did depense
            $table->string('uidCreator')->default('none')->index('uidCreator');//uyakiriye
            $table->string('subscriber')->default('none')->index('subscriber');
            $table->string('status')->default('none')->index('status');
            $table->string('liveLocation')->default('none')->index('liveLocation');
            $table->string('eta')->default('none')->index('eta');
            $table->longtext('commentData')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('status_tracks');
    }
}
