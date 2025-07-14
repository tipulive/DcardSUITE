<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTicketpricingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ticketpricings', function (Blueprint $table) {
            $table->id();
            $table->string('uid')->index();
            $table->string('name')->nullable();
            $table->string('price')->default("none");
            $table->longtext('descr')->nullable();
            $table->string('status')->index();
            $table->string('statusLive')->index();
            $table->longtext('commentData')->nullable();
            $table->string('uidCreator')->index('uidCreator');
            $table->string('subscriber')->default('none')->index("subscriber");
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
        Schema::dropIfExists('ticketpricings');
    }
}
