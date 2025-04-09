<!DOCTYPE html>
  <html>
  <head>
  <title>My experiment</title>
  <script src="https://unpkg.com/jspsych@8.0.0"></script>
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
            stimulus: "Press Y (for Yes) if the sentence was in the story you read. Press N (for No) if the sentence was not in the story you read."
          };
          timeline.push(instructions);
          
          // Sentences for recognition trials
          var storySentences = [
            { sentence: "I need to get some work done around the farm.", correct_response: "Y" },
            { sentence: "I gather the hay and take it to the cow.", correct_response: "Y" },
            { sentence: "I collect eggs from the chicken coop.", correct_response: "Y" },
            { sentence: "I place the eggs in the nearby basket.", correct_response: "Y" },
            { sentence: "I gather the pumpkins from the field.", correct_response: "Y" },
            { sentence: "I bring the pumpkins to the pigs.", correct_response: "Y" },
            { sentence: "The pigs munch the pumpkins right away.", correct_response: "Y" },
            { sentence: "I grab the watering can from the barn.", correct_response: "Y" },
            { sentence: "I water the garden so the vegetables can grow.", correct_response: "Y" },
            { sentence: "All the animals are fed, and the farm is taken care of.", correct_response: "Y" },
            { sentence: "I milk the cow and carry the bucket to the house.", correct_response: "N" },
            { sentence: "I find eggs hidden in the hay and wash them.", correct_response: "N" },
            { sentence: "I carry the pumpkins into the barn for storage.", correct_response: "N" },
            { sentence: "The pigs roll around in the mud near the field.", correct_response: "N" },
            { sentence: "I pour water into the trough for the horses.", correct_response: "N" },
            { sentence: "I use the watering can to fill the animal's bowl.", correct_response: "N" },
            { sentence: "The chickens run to the corn I’ve spread for them.", correct_response: "N" },
            { sentence: "I gather tomatoes from the garden.", correct_response: "N" },
            { sentence: "I load hay onto the tractor to move it around.", correct_response: "N" },
            { sentence: "All the animals rest while I fix the fence.", correct_response: "N" },
          ];
          
          // Shuffle the sentences for randomization
          const shuffledSentences = jsPsych.randomization.shuffle(storySentences);
          
          // Define recognition trial for each sentence
          var recognitionTrials = shuffledSentences.map((item) => {
            return {
              type: jsPsychHtmlKeyboardResponse,
              stimulus: `<p>${item.sentence}</p><p><em>Press Y for In Story, N for Not in Story</em></p>`,
              choices: ["Y", "N"],
              data: {
                sentence: item.sentence,
                correct_response: item.correct_response
              },
              on_finish: function (data) {
                data.correct = data.response === data.correct_response;
              }
            };
          });
          
          // End screen
          const endScreen = {
            type: jsPsychHtmlKeyboardResponse,
            stimulus: `<p>Thanks for completing the task!</p><p>Press any key to continue.</p>`
          };
          
          // Save data to DataPipe and send to OSF
          const save_data = {
            type: jsPsychPipe,
            action: "save",
            experiment_id: "m2XXEFg230tu",
            filename: `${jsPsych.randomization.randomID(10)}.csv`,
            data_string: () => jsPsych.data.get().csv()
          };
          
          // Add all components to the timeline
          timeline.push(...recognitionTrials);
          timeline.push(endScreen);
          timeline.push(save_data);
          
          // Run the experiment
          jsPsych.run(timeline);
          </script>
            </html>
            