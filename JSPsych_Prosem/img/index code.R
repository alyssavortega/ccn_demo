<!DOCTYPE html>
  <html>
  <head>
  <title>My experiment</title>
  <script src="https://unpkg.com/jspsych@8.0.0"></script>
    <script src="https://unpkg.com/@jspsych/plugin-image-keyboard-response@2.0.0"></script>
      <script src="https://unpkg.com/@jspsych/plugin-html-keyboard-response@2.0.0"></script>
        <script src="https://unpkg.com/@jspsych-contrib/plugin-pipe"></script>
          <link href="https://unpkg.com/jspsych@8.0.0/css/jspsych.css" rel="stylesheet" type="text/css" />
            </head>
            <body></body>
            <script>
            var jsPsych = initJsPsych();
            var timeline = [];
            var instructions = {
              type: jsPsychHtmlKeyboardResponse,
              stimulus: "In this task, you'll do stuff"
            };
            timeline.push(instructions);
            
            var image_trial = {
              type: jsPsychImageKeyboardResponse,
              stimulus: "orange_cat.jpg",
              choices: ["o", "b"],
              prompt: "press O for cute orange cat, press B for cute black cat"
            };
            timeline.push(image_trial);
            
            //defining fixation
            var fixation = {
              type: jsPsychHtmlKeyboardResponse,
              stimulus: "+",
              choice: "NO_KEYS",
              trial_duration: 500 //ms
            };
            
            var image_trial_timevar = {
              type: jsPsychImageKeyboardResponse,
              stimulus: jsPsych.timelineVariable("image"),
              choices: ["o", "b"],
              prompt: "press O for cute orange cat, press B for cute black cat"
            };
            
            var trial_procedure = {
              timeline: [fixation, image_trial_timevar],
              timeline_variables: [
                {image: "orange_cat.jpg", name: "Orange"},
                {image: "black_cat.jpg", name: "Black"}
              ]
            } 
            
            timeline.push(trial_procedure)
            
            const subject_id = jsPsych.randomization.randomID(10);
            const filename = `${subject_id}.csv`;
            
            
            const save_data = {
              type: jsPsychPipe,
              action: "save",
              experiment_id: "m2XXEFg230tu",
              filename: filename,
              data_string: ()=>jsPsych.data.get().csv()
            };
            
            timeline.push(save_data)
            
            jsPsych.run(timeline);
            </script>
              </html>