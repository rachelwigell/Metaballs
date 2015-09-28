$('#dipole-mode').click(function(){
	var processing = Processing.getInstanceById('processing');
	processing.toggleMode(true);
})

$('#repel-mode').click(function(){
	var processing = Processing.getInstanceById('processing');
	processing.toggleMode(false);
})