<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePricingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pricings', function (Blueprint $table) {
            $table->id();

            $table->string('uid')->default("none")->index("uid");
            $table->string('name')->index("name");
            $table->string('price')->index("price");
            $table->string('uidCreator')->index('uidCreator');
             $table->string('subscriber')->default('none')->index("subscriber");
             $table->string('status')->default('none')->index("status");
             $table->string('statusLive')->default('none')->index("statusLive");
             $table->longtext('commentData')->nullable();//
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
        Schema::dropIfExists('pricings');
    }
}
