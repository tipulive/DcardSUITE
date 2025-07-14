<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDrivingCatsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('driving_cats', function (Blueprint $table) {
            $table->id();
            $table->string('userId')->index(); // assuming indangamuntu is a string (like national ID)

            $table->string('DNO')->index()->nullable();
            $table->string('category')->index();
            $table->string('tel'); // add index for faster search
            $table->string('uidPrice')->index(); // adjust precision/scale as needed
            $table->string('price')->nullable();
            $table->string('status')->index();
            $table->string('statusLive')->index();
            $table->string('placeIssue');
            $table->string('uidCreator')->index('uidCreator');
            $table->string('subscriber')->default('none')->index("subscriber");
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
        Schema::dropIfExists('driving_cats');
    }
}
