package;

import flixel.input.gamepad.FlxGamepad;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;

import flash.display.BlendMode;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class IntroCutsceneState extends MusicBeatState
{
	/*
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['story mode', 'freeplay', 'donate', 'options'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.6" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var magenta:FlxSprite;
	*/
	//var camFollow:FlxObject;
	//public static var finishedFunnyMove:Bool = false;

	//var file_path = 'openingCutscene/';

	var waitingForPlayerInput = false;
	var playRain = false;
	var currentScene = 1;
	var currentPart = 1;

	var cutscene_image:FlxSprite;
	var rain:FlxSprite;
	var rain_counter = 0;

	
	var rain2:FlxSprite;
	var rain3:FlxSprite;


	var gf_message:FlxSprite;
	var bf_message:FlxSprite;


	var gf_room:FlxSprite;
	var gf_room2:FlxSprite;
	var gf_room3:FlxSprite;
	var scene_8_light:FlxSprite;


	// Oh boy time for these
	var scene_twoAndSix_BG:String = 'openingCutscene/Scene 2&6 Background';
	var scene_twelve_BG:String = 'openingCutscene/Scene 12 Background';

	var rain_images:Array<String> = [for (i in 1...4) 'openingCutscene/Scene 2&12 Rain ${i}'];

	var scene_one:Array<String> = [for (i in 1...10) 'openingCutscene/Scene 1-${i}'];
	//var scene_two_texts:Array<String> = [for (i in 1...8) 'openingCutscene/Scene 2-${i}'];
	var scene_two_gf_texts:Array<String> = [
		'openingCutscene/Scene 2-1',
		'openingCutscene/Scene 2-3',
		'openingCutscene/Scene 2-4',
		'openingCutscene/Scene 2-7'
	];
	var scene_two_bf_texts:Array<String> = [
		'openingCutscene/Scene 2-2',
		'openingCutscene/Scene 2-5',
		'openingCutscene/Scene 2-6'
	];
	var scene_three:String = 'openingCutscene/Scene 3';
	var scene_four:String = 'openingCutscene/Scene 4';
	var scene_five:String = 'openingCutscene/Scene 5';
	//var scene_six_texts:Array<String> = [for (i in 1...5) 'openingCutscene/Scene 6-${i}'];
	var scene_six_gf_texts:Array<String> = [
		'openingCutscene/Scene 6-1',
		'openingCutscene/Scene 6-3'
	];
	var scene_six_bf_texts:Array<String> = [
		'openingCutscene/Scene 6-2',
		'openingCutscene/Scene 6-4'
	];
	var scene_seven:String = 'openingCutscene/Scene 7';
	  // There are actually 81 parts in scene 8
	var scene_eight:Array<String> = [
		for (i in 1...82)
		{
			if (i < 13)
			{
				'openingCutscene/Scene 8-${i}';
			}
			else
			{
				'openingCutscene/Scene 8-${i + 1}';
			}
		}
	];
	var scene_nine:String = 'openingCutscene/Scene 9';
	var scene_ten:String = 'openingCutscene/Scene 10';
	var scene_eleven:String = 'openingCutscene/Scene 11';
	//var scene_twelve_texts:Array<String> = [for (i in 1...5) 'openingCutscene/Scene 12-${i}'];
	var scene_twelve_gf_texts:Array<String> = [
		'openingCutscene/Scene 12-1',
		'openingCutscene/Scene 12-2',
		'openingCutscene/Scene 12-3'
	];
	var scene_twelve_bf_text:String = 'openingCutscene/Scene 12-4';
	var scene_thirteen:Array<String> = [for (i in 1...7) 'openingCutscene/Scene 13-${i}'];
	var scene_fourteen:Array<String> = [for (i in 1...4) 'openingCutscene/Scene 14-${i}'];
	var scene_fifteen:Array<String> = [for (i in 1...4) 'openingCutscene/Scene 15-${i}'];
	var scene_sixteen:Array<String> = [for (i in 1...4) 'openingCutscene/Scene 16-${i}'];
	var scene_seventeen:Array<String> = [for (i in 1...5) 'openingCutscene/Scene 17-${i}'];
	var scene_eighteen:Array<String> = [for (i in 1...3) 'openingCutscene/Scene 18-${i}'];
	var scene_nineteen:String = 'openingCutscene/Scene 19';
	var scene_twenty:Array<String> = [for (i in 1...5) 'openingCutscene/Scene 20-${i}'];
	var scene_twentyone:Array<String> = [for (i in 1...5) 'openingCutscene/Scene 21-${i}'];
	var scene_twentytwo:Array<String> = [for (i in 1...4) 'openingCutscene/Scene 22-${i}'];


	
	var scene_8_gf_room:Array<String> = [
		'openingCutscene/GFs_Room_-_Pearly_1',
		'openingCutscene/GFs_Room_-_Pearly_2',
		'openingCutscene/GFs_Room'
	];

	//var scene_8_real:Array<FlxSprite> = [];
	//var scene_8_real:List<FlxSprite>;
	var scene_8_real = new haxe.ds.List<FlxSprite>();

	var scene_17_real:Array<FlxSprite> = [];
	var scene_18_real:Array<FlxSprite> = [];
	/*var scene_8_real:Array<FlxSprite> = [
		for (i in 0...81)
		{
			addScene8Frame(i);
		}
	];*/

	/*
	Misc: 3 rain images
	Scene 1: 9 images
	Scene 2: BG, 7 images, [rain]
	Scene 3, 4, 5: 1 image
	Scene 6: BG, 4 images, [rain]
	Scene 7: 1 image
	Scene 8: 82 images
	Scene 9, 10, 11: 1 image
	Scene 12: BG2, 4 images, [rain]
	Scene 13: 6 images
	Scene 14: 3 images
	Scene 15: 3 images
	Scene 16: 3 images
	Scene 17: 4 images
	Scene 18: 2 images
	Scene 19: 1 image
	Scene 20: 4 images
	Scene 21: 4 images
	Scene 22: 3 images
	*/

	override function create()
	{
		
		cutscene_image = new FlxSprite(/*-400,-760*/);
		cutscene_image.loadGraphic(Paths.image(scene_one[0]));
		cutscene_image.scrollFactor.set();
		cutscene_image.screenCenter();
		if(FlxG.save.data.antialiasing)
		{
			cutscene_image.antialiasing = true;
		}
		add(cutscene_image);

		FlxG.camera.zoom = 0.535;


		// Get rain ready
		rain = new FlxSprite();
		rain.loadGraphic(Paths.image(rain_images[0/*rain_counter*/]));
		rain.scrollFactor.set();
		rain.screenCenter();
		if(FlxG.save.data.antialiasing)
		{
			rain.antialiasing = true;
		}

		// Funny rain idea
		rain2 = new FlxSprite();
		rain2.loadGraphic(Paths.image(rain_images[1]));
		rain2.scrollFactor.set();
		rain2.screenCenter();
		if(FlxG.save.data.antialiasing)
		{
			rain2.antialiasing = true;
		}

		rain3 = new FlxSprite();
		rain3.loadGraphic(Paths.image(rain_images[2]));
		rain3.scrollFactor.set();
		rain3.screenCenter();
		if(FlxG.save.data.antialiasing)
		{
			rain3.antialiasing = true;
		}

		// Get GF's first floating text message ready
		gf_message = new FlxSprite();
		gf_message.loadGraphic(Paths.image(scene_two_gf_texts[0]));
		gf_message.scrollFactor.set();
		gf_message.screenCenter();
		if(FlxG.save.data.antialiasing)
		{
			gf_message.antialiasing = true;
		}

		// Get BF's first floating text message ready
		bf_message = new FlxSprite();
		bf_message.loadGraphic(Paths.image(scene_two_bf_texts[0]));
		bf_message.scrollFactor.set();
		bf_message.screenCenter();
		if(FlxG.save.data.antialiasing)
		{
			bf_message.antialiasing = true;
		}


		// GF room backdrop for scene 8 panning
		gf_room = new FlxSprite();
		gf_room.loadGraphic(Paths.image(scene_8_gf_room[0]));
		gf_room.scrollFactor.set();
		gf_room.screenCenter();
		if(FlxG.save.data.antialiasing)
		{
			gf_room.antialiasing = true;
		}

		gf_room2 = new FlxSprite();
		gf_room2.loadGraphic(Paths.image(scene_8_gf_room[1]));
		gf_room2.scrollFactor.set();
		gf_room2.screenCenter();
		if(FlxG.save.data.antialiasing)
		{
			gf_room2.antialiasing = true;
		}

		gf_room3 = new FlxSprite();
		gf_room3.loadGraphic(Paths.image(scene_8_gf_room[2]));
		gf_room3.scrollFactor.set();
		gf_room3.screenCenter();
		if(FlxG.save.data.antialiasing)
		{
			gf_room3.antialiasing = true;
		}

		// Scene 8 light overlay
		scene_8_light = new FlxSprite();
		scene_8_light.loadGraphic(Paths.image('openingCutscene/Purple_With_Light'));
		scene_8_light.scrollFactor.set();
		scene_8_light.screenCenter();
		if(FlxG.save.data.antialiasing)
		{
			scene_8_light.antialiasing = true;
		}
		scene_8_light.blend = "multiply";

		  // Do the same thing as above for the scene 17 images, but
		  // this is starting to get too cluttered so go to it somewhere
		  // else in the file.
		prepareScene17();
		prepareScene18();

		////// NOW, START CUTSCENE
		startCutscene();

	}

	// Oh boy its funky time

	// Get these scene images ready
	function prepareScene17():Void
	{
		for (i in 0...4)
		{
			scene_17_real[i] = new FlxSprite();
			scene_17_real[i].loadGraphic(Paths.image(scene_seventeen[i]));
			scene_17_real[i].scrollFactor.set();
			scene_17_real[i].screenCenter();
			if(FlxG.save.data.antialiasing)
			{
				scene_17_real[i].antialiasing = true;
			}
		}
	}

	function prepareScene18():Void
	{
		for (i in 0...2)
		{
			scene_18_real[i] = new FlxSprite();
			scene_18_real[i].loadGraphic(Paths.image(scene_eighteen[i]));
			scene_18_real[i].scrollFactor.set();
			scene_18_real[i].screenCenter();
			if(FlxG.save.data.antialiasing)
			{
				scene_18_real[i].antialiasing = true;
			}
		}
	}

	// Update function
	override function update(elapsed:Float)
	{
		if (PlayerSettings.player1.controls.ACCEPT && waitingForPlayerInput)
		{
			// SCENE 1
			if (currentScene == 1)
			{
				if (currentPart == 2) // Display the "..." and then automatically put up the message
				{
					waitingForPlayerInput = false;
					cutscene_image.loadGraphic(Paths.image(scene_one[2]));
					currentPart = 3;

					new FlxTimer().start(1.0, function(tmr:FlxTimer)
					{
						cutscene_image.loadGraphic(Paths.image(scene_one[3]));
						currentPart = 4;
						waitingForPlayerInput = true;
						FlxG.sound.play(Paths.sound('text_ping'));
					});
				}
				else if (currentPart > 3) // Manually go through the rest of the messages
				{
					++currentPart;
					if (currentPart > 9)
					{
						startSceneTwo();
					}
					else
					{
						cutscene_image.loadGraphic(Paths.image(scene_one[currentPart - 1]));
						FlxG.sound.play(Paths.sound('text_ping'));
					}
				}
			}
			// SCENE 2
			else if (currentScene == 2)
			{
				if (currentPart == 1) // bf: parent emojis
				{
					++currentPart;
					add(bf_message);
					FlxG.sound.play(Paths.sound('text_ping'));
				}
				else if (currentPart == 2) // dad @ concert mom @ party
				{
					++currentPart;
					gf_message.loadGraphic(Paths.image(scene_two_gf_texts[1]));
					FlxG.sound.play(Paths.sound('text_ping'));
				}
				else if (currentPart == 3) // im all alone itll just b u&me wink
				{
					++currentPart;
					remove(bf_message);
					//bf_message.alpha = 0.0;
					gf_message.loadGraphic(Paths.image(scene_two_gf_texts[2]));
					FlxG.sound.play(Paths.sound('text_ping'));
				}
				else if (currentPart == 4) // bf: blush emoji
				{
					++currentPart;
					bf_message.loadGraphic(Paths.image(scene_two_bf_texts[1]));
					add(bf_message);
					FlxG.sound.play(Paths.sound('text_ping'));
				}
				else if (currentPart == 5) // bf: house camera emoji
				{
					++currentPart;
					remove(gf_message);
					bf_message.loadGraphic(Paths.image(scene_two_bf_texts[2]));
					FlxG.sound.play(Paths.sound('text_ping'));
				}
				else if (currentPart == 6) // oh yeah theyd prob c u on the security cams when they get back
				{
					++currentPart;
					gf_message.loadGraphic(Paths.image(scene_two_gf_texts[3]));
					add(gf_message);
					FlxG.sound.play(Paths.sound('text_ping'));
				}
				else if (currentPart == 7) // --- Wait for player input to move into scene 3
				{
					waitingForPlayerInput = false; // without this here, player is able to trigger the following shit multiple times
					  // door creak
					FlxG.sound.play(Paths.sound('Door Creak'));
					new FlxTimer().start(0.8, function(tmr:FlxTimer)
					{
						startSceneThree();
					});
				}
			}
			// SCENE 6
			else if (currentScene == 6)
			{
				if (currentPart == 1) // bf: ? emoji
				{
					++currentPart;
					bf_message.loadGraphic(Paths.image(scene_six_bf_texts[0]));
					add(bf_message);
					FlxG.sound.play(Paths.sound('text_ping'));
				}
				else if (currentPart == 2) // wink emoji
				{
					++currentPart;
					gf_message.loadGraphic(Paths.image(scene_six_gf_texts[1]));
					FlxG.sound.play(Paths.sound('text_ping'));
				}
				else if (currentPart == 3) // bf: heart emojis
				{
					++currentPart;
					bf_message.loadGraphic(Paths.image(scene_six_bf_texts[1]));
					FlxG.sound.play(Paths.sound('text_ping'));
				}
				else if (currentPart == 4) // --- Wait for player input to move into scene 7
				{
					waitingForPlayerInput = false; // without this here, player is able to trigger the following shit multiple times
					  // footsteps
					FlxG.sound.play(Paths.sound('Footsteps'));
					new FlxTimer().start(0.8, function(tmr:FlxTimer)
					{
						startSceneSeven();
					});
				}
			}
			// SCENE 12
			else if (currentScene == 12)
			{
				if (currentPart == 1) // im hearing thngs & th thundrs not helpng
				{
					++currentPart;
					gf_message.loadGraphic(Paths.image(scene_twelve_gf_texts[1]));
					FlxG.sound.play(Paths.sound('text_ping'));
				}
				else if (currentPart == 2) // feels creepy dont want 2 be alone
				{
					++currentPart;
					gf_message.loadGraphic(Paths.image(scene_twelve_gf_texts[2]));
					FlxG.sound.play(Paths.sound('text_ping'));
				}
				else if (currentPart == 3) // bf: thumbs up emoji
				{
					++currentPart;
					bf_message.loadGraphic(Paths.image(scene_twelve_bf_text));
					add(bf_message);
					FlxG.sound.play(Paths.sound('text_ping'));
				}
				else if (currentPart == 4) // --- Wait for player input to move into scene 13
				{
					startSceneThirteen();
				}
			}
			// SCENE 12
			else if (currentScene == 16)
			{
				  // Wait for player input, then jumpscare them with thunder haha
				startSceneSeventeen();
			}
		}
	}

	function startRain(part1:FlxSprite, part2:FlxSprite, part3:FlxSprite):Void
	{
		//rain.loadGraphic(Paths.image(rain_images[0]));
		part1.alpha = 1.0;
		part2.alpha = 0.0;
		part3.alpha = 0.0;
		add(part1);
		add(part2);
		add(part3);
		playRain = true;
		rain_counter = 1;
		new FlxTimer().start(0.06, function(tmr:FlxTimer)
		{
			if (!playRain)
			{
				tmr.cancel();
				remove(part1);
				remove(part2);
				remove(part3);
			}
			else
			{
				/*********************************************
				* For some ungodly, abyssal reason, adding and removing a different sprite object each time
				* is INFINITELY faster than loadGraphic, because I have no idea how to use loadGraphic 
				* more efficiently and yes this could be solved if I just did an animation instead.
				* But you know what? Fuck it, yeet
				*********************************************/
				if (rain_counter == 0)
				{
					part1.alpha = 1.0;
					part3.alpha = 0.0;
				}
				else if (rain_counter == 1)
				{
					part2.alpha = 1.0;
					part1.alpha = 0.0;
				}
				else if (rain_counter == 2)
				{
					part3.alpha = 1.0;
					part2.alpha = 0.0;
				}

				if (rain_counter > 1)
				{
					rain_counter = 0;
				}
				else
				{
					++rain_counter;
				}
			}
		}, 0); // 0 means loop foreverrrr until we tell it to stop
	}
	
	// 2-frame version
	function startRain2(part1:FlxSprite, part2:FlxSprite):Void
	{
		part1.alpha = 1.0;
		part2.alpha = 0.0;
		add(part1);
		add(part2);
		playRain = true;
		rain_counter = 1;
		new FlxTimer().start(0.06, function(tmr:FlxTimer)
		{
			if (!playRain)
			{
				tmr.cancel();
				remove(part1);
				remove(part2);
			}
			else
			{
				if (rain_counter == 0)
				{
					part1.alpha = 1.0;
					part2.alpha = 0.0;
				}
				else if (rain_counter == 1)
				{
					part2.alpha = 1.0;
					part1.alpha = 0.0;
				}

				if (rain_counter > 0)
				{
					rain_counter = 0;
				}
				else
				{
					++rain_counter;
				}
			}
		}, 0);
	}


	// Keeping the old function in case I break something
	function startRain0():Void
	{
		//rain.loadGraphic(Paths.image(rain_images[0]));
		rain.alpha = 1.0;
		rain2.alpha = 0.0;
		rain3.alpha = 0.0;
		add(rain);
		add(rain2);
		add(rain3);
		playRain = true;
		rain_counter = 1;
		new FlxTimer().start(0.06, function(tmr:FlxTimer)
		{
			if (!playRain)
			{
				tmr.cancel();
				remove(rain);
				remove(rain2);
				remove(rain3);
			}
			else
			{
				//trace(rain_counter);
				//rain.loadGraphic(Paths.image(rain_images[rain_counter]));
				//++rain_counter;

				/*********************************************
				* For some ungodly, abyssal reason, adding and removing a different sprite object each time
				* is INFINITELY faster than loadGraphic, because I have no idea how to use loadGraphic 
				* more efficiently and yes this could be solved if I just did an animation instead.
				* But you know what? Fuck it, yeet
				*********************************************/
				if (rain_counter == 0)
				{
					//add(rain);
					//remove(rain3);
					rain.alpha = 1.0;
					rain3.alpha = 0.0;
				}
				else if (rain_counter == 1)
				{
					//add(rain2);
					//remove(rain);
					rain2.alpha = 1.0;
					rain.alpha = 0.0;
				}
				else if (rain_counter == 2)
				{
					//add(rain3);
					//remove(rain2);
					rain3.alpha = 1.0;
					rain2.alpha = 0.0;
				}


				if (rain_counter > 1)
				{
					rain_counter = 0;
				}
				else
				{
					++rain_counter;
				}
			}
		}, 0);
	}
	
	// Now, time for cutscene functions
	function startCutscene():Void
	{
		  // rain sounds
		FlxG.sound.play(Paths.sound('cutscene_rain'), 1, true);

		new FlxTimer().start(1.0, function(tmr:FlxTimer)
		{
			cutscene_image.loadGraphic(Paths.image(scene_one[1]));
			currentPart = 2;
			waitingForPlayerInput = true;
			FlxG.sound.play(Paths.sound('text_ping'));
		});
	}

	function startSceneTwo():Void
	{
		// set scene and part
		currentScene = 2;
		currentPart = 1;
		cutscene_image.loadGraphic(Paths.image(scene_twoAndSix_BG)); // load up that bg baybee
		
		// get that rain in
		startRain(rain, rain2, rain3);

		// Wait a couple seconds, then put up GF's first text message
		waitingForPlayerInput = false;
		new FlxTimer().start(1.0, function(tmr:FlxTimer)
		{
			add(gf_message); // mom&dad not home, cum ovr
			waitingForPlayerInput = true;
			FlxG.sound.play(Paths.sound('text_ping'));
		});
	}

	function startSceneThree():Void
	{
		waitingForPlayerInput = false;

		playRain = false; // Make sure to turn off that rain timer loop
		//remove(rain);
		//remove(rain2);
		//remove(rain3);
		remove(gf_message);
		remove(bf_message);

		cutscene_image.loadGraphic(Paths.image(scene_three));
		new FlxTimer().start(1.0, function(tmr:FlxTimer) // Wait for scene 3 to finish, then do scene 4 afterwards
		{
			cutscene_image.loadGraphic(Paths.image(scene_four));
			new FlxTimer().start(1.0, function(tmr:FlxTimer) // Do scene 5 after that
			{
				cutscene_image.loadGraphic(Paths.image(scene_five));
				new FlxTimer().start(1.0, function(tmr:FlxTimer) // And then go into scene 6 after that
				{
					startSceneSix();
				});
			});
		});
	}

	function startSceneSix():Void
	{
		currentScene = 6;
		currentPart = 1;
		cutscene_image.loadGraphic(Paths.image(scene_twoAndSix_BG)); // same bg as before
		
		// get that rain in again
		startRain(rain, rain2, rain3);

		// Like last time, wait a couple seconds, then put up GF's message
		waitingForPlayerInput = false;
		new FlxTimer().start(1.0, function(tmr:FlxTimer)
		{
			gf_message.loadGraphic(Paths.image(scene_six_gf_texts[0]));
			add(gf_message); // wll if you cant cm ovr mybe we can do smthng ovr the phone
			waitingForPlayerInput = true;
			FlxG.sound.play(Paths.sound('text_ping'));
		});
	}

	function startSceneSeven():Void
	{
		waitingForPlayerInput = false;

		playRain = false; // Make sure to turn off that rain timer loop
		//remove(rain);
		//remove(rain2);
		//remove(rain3);
		remove(gf_message);
		remove(bf_message);

		cutscene_image.loadGraphic(Paths.image(scene_seven));
		new FlxTimer().start(2.0, function(tmr:FlxTimer) // hold on scene 7
		{
			  // Welp, we're gonna pan instead
			add(gf_room);
			add(gf_room2);
			add(gf_room3);
			gf_room.x += 725;
			gf_room2.x += 725;
			gf_room3.x += 725;
			gf_room2.alpha = 0.0;
			gf_room3.alpha = 0.0;
			add(scene_8_light); // Add the light overlay
			  // (gf_room is 3845 px wide)
			  // Pan over, 5 minute duration
			new FlxTimer().start(0.5, function(tmr:FlxTimer)
			{
				FlxTween.tween(gf_room, {x: gf_room.x - 1400}, 10.0, {
					ease: FlxEase.sineOut,
					onComplete: function(twn:FlxTween)
					{
						gf_room.destroy();
						scene_8_light.destroy();
						startSceneNine();
					}
				}); // tween end
				FlxTween.tween(gf_room2, {x: gf_room2.x - 1400}, 10.0, {
					ease: FlxEase.sineOut,
					onComplete: function(twn:FlxTween)
					{
						gf_room2.destroy();
					}
				});
				FlxTween.tween(gf_room3, {x: gf_room3.x - 1400}, 10.0, {
					ease: FlxEase.sineOut,
					onComplete: function(twn:FlxTween)
					{
						gf_room3.destroy();
					}
				});

				  // Pearly ducks
				new FlxTimer().start(6.0, function(tmr:FlxTimer)
				{
					gf_room2.alpha = 1.0;
					gf_room.alpha = 0.0;
					new FlxTimer().start(0.03, function(tmr:FlxTimer)
					{
						gf_room3.alpha = 1.0;
						gf_room2.alpha = 0.0;
					});
				});

			});
		});
	}


	function startSceneNine():Void
	{
		// hold on the last frame of scene 8 for like a second?????


		cutscene_image.loadGraphic(Paths.image(scene_nine));
		new FlxTimer().start(0.5, function(tmr:FlxTimer)
		{
				
			  // thunder
			FlxG.sound.play(Paths.sound('thunder_2'));
			cutscene_image.loadGraphic(Paths.image(scene_ten)); // lightning
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				cutscene_image.loadGraphic(Paths.image(scene_eleven));
				new FlxTimer().start(1.0, function(tmr:FlxTimer)
				{
					startSceneTwelve();
				});
			});
		});
	}

	function startSceneTwelve():Void
	{
		currentScene = 12;
		currentPart = 1;
		cutscene_image.loadGraphic(Paths.image(scene_twelve_BG)); // new bg this time
		
		// get that rain in again (again)
		startRain(rain, rain2, rain3);

		// Once again, wait a couple seconds, then put up GF's message
		waitingForPlayerInput = false;
		new FlxTimer().start(1.0, function(tmr:FlxTimer)
		{
			gf_message.loadGraphic(Paths.image(scene_twelve_gf_texts[0]));
			add(gf_message); // hey... can i cme ovr 2 your place actually?
			waitingForPlayerInput = true;
			FlxG.sound.play(Paths.sound('text_ping'));
		});
	}

	function startSceneThirteen():Void
	{
		waitingForPlayerInput = false;

		//playRain = false; // Make sure to turn off that rain timer loop
		//remove(rain);
		//remove(rain2);
		//remove(rain3);
		remove(gf_message);
		remove(bf_message);
		cutscene_image.loadGraphic(Paths.image(scene_nineteen)); // Ready cutscene_image for when it next comes up
		remove(cutscene_image);
		//cutscene_image.loadGraphic(Paths.image(scene_seven));
		rain.loadGraphic(Paths.image(scene_thirteen[0]));
		rain2.loadGraphic(Paths.image(scene_thirteen[1]));
		rain3.loadGraphic(Paths.image(scene_thirteen[2]));

		//playRain = false;
		//startRain(rain, rain2, rain3);


		new FlxTimer().start(2.0, function(tmr:FlxTimer) // gf looks up
		{
			rain.loadGraphic(Paths.image(scene_thirteen[3]));
			rain2.loadGraphic(Paths.image(scene_thirteen[4]));
			rain3.loadGraphic(Paths.image(scene_thirteen[5]));
			new FlxTimer().start(2.0, function(tmr:FlxTimer) // scene 14 (pearly sitting there in front of her)
			{
				rain.loadGraphic(Paths.image(scene_fourteen[0]));
				rain2.loadGraphic(Paths.image(scene_fourteen[1]));
				rain3.loadGraphic(Paths.image(scene_fourteen[2]));
				new FlxTimer().start(3.0, function(tmr:FlxTimer) // scene 15 (side view of pearly looking at gf)
				{
					rain.loadGraphic(Paths.image(scene_fifteen[0]));
					rain2.loadGraphic(Paths.image(scene_fifteen[1]));
					rain3.loadGraphic(Paths.image(scene_fifteen[2]));
					new FlxTimer().start(3.0, function(tmr:FlxTimer) // scene 16 (close up)
					{
						rain.loadGraphic(Paths.image(scene_sixteen[0]));
						rain2.loadGraphic(Paths.image(scene_sixteen[1]));
						rain3.loadGraphic(Paths.image(scene_sixteen[2]));
						waitingForPlayerInput = true;
						currentScene = 16;
					});
				});
			});
		});
	}

	
	//0.06 - before bolt
	//0.24 - white flash
	//0.36 - lit up
	//0.60 - gf closeup
	//0.36 - phone drop

	function startSceneSeventeen():Void
	{
		waitingForPlayerInput = false;

		playRain = false; // Make sure to turn off that rain timer loop
		//remove(rain);
		//remove(rain2);
		//remove(rain3);
				
		  // thunder
		FlxG.sound.play(Paths.sound('thunder_1'));

		add(scene_17_real[0]);                                    // Lightning strike
		new FlxTimer().start(0.06, function(tmr:FlxTimer)
		{
			remove (scene_17_real[0]);
			add(scene_17_real[1]);                                // White flash
			new FlxTimer().start(0.24, function(tmr:FlxTimer) 
			{
				remove (scene_17_real[1]);
				startRain2(scene_17_real[2], scene_17_real[3]);    // lit up
				new FlxTimer().start(0.36, function(tmr:FlxTimer) 
				{
					playRain = false;
					startSceneEighteen();
				});
				/*
				add(scene_17_real[2]);                            // Lightning illumination (2 frames)
				new FlxTimer().start(0.4, function(tmr:FlxTimer)
				{
					remove (scene_17_real[2]);
					add(scene_17_real[3]);
					new FlxTimer().start(0.4, function(tmr:FlxTimer)
					{
						remove(scene_17_real[3]);
						startSceneEighteen();
					});
		
				});*/
	
			});

		});
	}


	function startSceneEighteen():Void
	{
		// GF frightened face
		//add(scene_18_real[0]);
		new FlxTimer().start(0.5, function(tmr:FlxTimer)
		{
			remove(scene_18_real[0]);
			add(scene_18_real[1]);
			new FlxTimer().start(0.5, function(tmr:FlxTimer)
			{
				 // load up the graphic before removing the other image, in case there's a pause (so we don't pause on blackness)
				remove(scene_18_real[1]);
				startSceneNineteen();
			});
		});
	}

	function startSceneNineteen():Void
	{
		add(cutscene_image); // GF drops phone
		new FlxTimer().start(1.5, function(tmr:FlxTimer)
		{
			  // Scene 20 time
			cutscene_image.loadGraphic(Paths.image(scene_twenty[0])); // bf: same thumbs up from earlier
			FlxG.sound.play(Paths.sound('text_ping'));
			new FlxTimer().start(2.0, function(tmr:FlxTimer)
			{
				cutscene_image.loadGraphic(Paths.image(scene_twenty[1])); // bf: gf?
				FlxG.sound.play(Paths.sound('text_ping'));
				new FlxTimer().start(1.0, function(tmr:FlxTimer)
				{
					cutscene_image.loadGraphic(Paths.image(scene_twenty[2])); // bf: ???
					FlxG.sound.play(Paths.sound('text_ping'));
					new FlxTimer().start(0.5, function(tmr:FlxTimer)
					{
						cutscene_image.loadGraphic(Paths.image(scene_twenty[3])); // bf: gf!?thumbsup?
						FlxG.sound.play(Paths.sound('text_ping'));
						new FlxTimer().start(2.0, function(tmr:FlxTimer)
						{
							startSceneTwentyone();
						});
		
					});
	
				});

			});
		});
	}

	function startSceneTwentyone():Void
	{
		  // Pearly responds
		cutscene_image.loadGraphic(Paths.image(scene_twentyone[0])); // ...
		new FlxTimer().start(1.5, function(tmr:FlxTimer)
		{
			cutscene_image.loadGraphic(Paths.image(scene_twentyone[1])); // devil girl chains
			FlxG.sound.play(Paths.sound('text_ping'));
			new FlxTimer().start(1.5, function(tmr:FlxTimer)
			{
				cutscene_image.loadGraphic(Paths.image(scene_twentyone[2])); // address
				FlxG.sound.play(Paths.sound('text_ping'));
				new FlxTimer().start(2.5, function(tmr:FlxTimer)
				{
					cutscene_image.loadGraphic(Paths.image(scene_twentyone[3])); // microphone
					FlxG.sound.play(Paths.sound('text_ping'));
					new FlxTimer().start(2.0, function(tmr:FlxTimer)
					{
						startSceneTwentytwo();
					});
				});
			});
		});
	}

	function startSceneTwentytwo():Void
	{
		cutscene_image.loadGraphic(Paths.image(scene_twentytwo[0])); // closeup on ...
		new FlxTimer().start(0.5, function(tmr:FlxTimer)
		{
			cutscene_image.loadGraphic(Paths.image(scene_twentytwo[1])); // cops = devil skull
			FlxG.sound.play(Paths.sound('text_ping'));
			new FlxTimer().start(1.5, function(tmr:FlxTimer)
			{
				cutscene_image.loadGraphic(Paths.image(scene_twentytwo[2])); // -Pearly
				FlxG.sound.play(Paths.sound('text_ping'));
				new FlxTimer().start(4.0, function(tmr:FlxTimer)
				{
					// AND THAT'S IT END OF CUTSCENE
					LoadingState.loadAndSwitchState(new PlayState(), true);
				});
			});
		});
	}

}
