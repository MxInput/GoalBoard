extends Node

@export var date_time_teller : RichTextLabel;

func _process(_delta: float) -> void:
	var datetime = Time.get_datetime_dict_from_system();
	
	var weekday = "";
	
	var remaining_hours = datetime["hour"] % 12;
	
	var time_period = "AM";
	
	var seconds = datetime["second"]
	var seconds_to_display;
	
	var minutes = datetime["minute"]
	var minutes_to_display;
	
	if (datetime["hour"] >= 12):
		time_period = "PM";
	else:
		time_period = "AM";
		
	if (seconds < 10):
		seconds_to_display = "0" + str(seconds);
	else:
		seconds_to_display = str(seconds);
	
	if (minutes < 10):
		minutes_to_display = "0" + str(minutes);	
	else:
		minutes_to_display = str(minutes);	
		
		
	if (datetime["hour"] == 0):
		remaining_hours = 12;
	
	match (datetime["weekday"]):
		Time.WEEKDAY_SUNDAY:
			weekday = "Sunday";
		Time.WEEKDAY_MONDAY:
			weekday = "Monday";
		Time.WEEKDAY_TUESDAY:
			weekday = "Tuesday";
		Time.WEEKDAY_WEDNESDAY:
			weekday = "Wednesday";
		Time.WEEKDAY_THURSDAY:
			weekday = "Thursday";
		Time.WEEKDAY_FRIDAY:
			weekday = "Friday";
		Time.WEEKDAY_SATURDAY:
			weekday = "Saturday";
			
	date_time_teller.text = str(datetime["month"]) + "/" + str(datetime["day"]) + "/" + str(datetime["year"]) + " (" + weekday + ") " + str(remaining_hours) + ":" + minutes_to_display + ":" + seconds_to_display + " " + time_period;
