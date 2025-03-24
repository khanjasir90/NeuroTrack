require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');
const { v4: uuidv4 } = require('uuid');

// Initialize Supabase client
const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_KEY
);

// Assessment data
const assessments = [
  {
    name: "Autism Spectrum Quotient (AQ-10)",
    description: "A brief screening tool for autism spectrum traits in adults aged 16 and over. It consists of 10 statements to assess behaviors and preferences.",
    category: "Autism Assessment",
    cutoff_score: 6,
    image_url: "https://gezbvdcskabwweanvfhu.supabase.co/storage/v1/object/public/neurotrack//aq10_icon.png",
    questions: [
      {
        question_id: generateRandomUUID(),
        text: "I often notice small sounds when others do not",
        options: [
          { option_id: generateRandomUUID(), text: "Definitely agree", score: 1 },
          { option_id: generateRandomUUID(), text: "Slightly agree", score: 1 },
          { option_id: generateRandomUUID(), text: "Slightly disagree", score: 0 },
          { option_id: generateRandomUUID(), text: "Definitely disagree", score: 0 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I usually concentrate more on the whole picture, rather than the small details",
        options: [
          { option_id: generateRandomUUID(), text: "Definitely agree", score: 0 },
          { option_id: generateRandomUUID(), text: "Slightly agree", score: 0 },
          { option_id: generateRandomUUID(), text: "Slightly disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Definitely disagree", score: 1 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I find it easy to do more than one thing at once",
        options: [
          { option_id: generateRandomUUID(), text: "Definitely agree", score: 0 },
          { option_id: generateRandomUUID(), text: "Slightly agree", score: 0 },
          { option_id: generateRandomUUID(), text: "Slightly disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Definitely disagree", score: 1 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "If there is an interruption, I can switch back to what I was doing very quickly",
        options: [
          { option_id: generateRandomUUID(), text: "Definitely agree", score: 0 },
          { option_id: generateRandomUUID(), text: "Slightly agree", score: 0 },
          { option_id: generateRandomUUID(), text: "Slightly disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Definitely disagree", score: 1 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I find it easy to 'read between the lines' when someone is talking to me",
        options: [
          { option_id: generateRandomUUID(), text: "Definitely agree", score: 0 },
          { option_id: generateRandomUUID(), text: "Slightly agree", score: 0 },
          { option_id: generateRandomUUID(), text: "Slightly disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Definitely disagree", score: 1 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I know how to tell if someone listening to me is getting bored",
        options: [
          { option_id: generateRandomUUID(), text: "Definitely agree", score: 0 },
          { option_id: generateRandomUUID(), text: "Slightly agree", score: 0 },
          { option_id: generateRandomUUID(), text: "Slightly disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Definitely disagree", score: 1 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "When I'm reading a story I find it difficult to work out the characters' intentions",
        options: [
          { option_id: generateRandomUUID(), text: "Definitely agree", score: 1 },
          { option_id: generateRandomUUID(), text: "Slightly agree", score: 1 },
          { option_id: generateRandomUUID(), text: "Slightly disagree", score: 0 },
          { option_id: generateRandomUUID(), text: "Definitely disagree", score: 0 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I like to collect information about categories of things (e.g. types of car, types of bird, types of train, types of plant etc)",
        options: [
          { option_id: generateRandomUUID(), text: "Definitely agree", score: 1 },
          { option_id: generateRandomUUID(), text: "Slightly agree", score: 1 },
          { option_id: generateRandomUUID(), text: "Slightly disagree", score: 0 },
          { option_id: generateRandomUUID(), text: "Definitely disagree", score: 0 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I find it easy to work out what someone is thinking or feeling just by looking at their face",
        options: [
          { option_id: generateRandomUUID(), text: "Definitely agree", score: 0 },
          { option_id: generateRandomUUID(), text: "Slightly agree", score: 0 },
          { option_id: generateRandomUUID(), text: "Slightly disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Definitely disagree", score: 1 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I find it difficult to work out people's intentions",
        options: [
          { option_id: generateRandomUUID(), text: "Definitely agree", score: 1 },
          { option_id: generateRandomUUID(), text: "Slightly agree", score: 1 },
          { option_id: generateRandomUUID(), text: "Slightly disagree", score: 0 },
          { option_id: generateRandomUUID(), text: "Definitely disagree", score: 0 }
        ]
      }
    ]
  },
  {
    name: "Camouflaging Autistic Traits Questionnaire (CAT-Q)",
    description: "A 25-item self-report measure designed to assess camouflaging strategies in individuals aged 16 years and older.",
    category: "Autism Assessment",
    cutoff_score: 100,
    image_url: "https://gezbvdcskabwweanvfhu.supabase.co/storage/v1/object/public/neurotrack//autism_icon.png",
    questions: [
      {
        question_id: generateRandomUUID(),
        text: "When I am interacting with someone, I deliberately copy their body language or facial expressions.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I monitor my body language or facial expressions so that I appear relaxed.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I rarely feel the need to put on an act in order to get through a social situation.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 7 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 6 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 5 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 3 },
          { option_id: generateRandomUUID(), text: "Agree", score: 2 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 1 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I have developed a script to follow in social situations.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I will repeat phrases that I have heard others say in the exact same way that I first heard them.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I adjust my body language or facial expressions so that I appear interested by the person I am interacting with.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "In social situations, I feel like I'm 'performing' rather than being myself.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "In my own social interactions, I use behaviours that I have learned from watching other people interacting.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I always think about the impression I make on other people.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I need the support of other people in order to socialise.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I practice my facial expressions and body language to make sure they look natural.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I don't feel the need to make eye contact with other people if I don't want to.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 7 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 6 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 5 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 3 },
          { option_id: generateRandomUUID(), text: "Agree", score: 2 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 1 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I have to force myself to interact with people when I am in social situations.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I have tried to improve my understanding of social skills by watching other people.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I monitor my body language or facial expressions so that I appear interested by the person I am interacting with.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "When in social situations, I try to find ways to avoid interacting with others.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I have researched the rules of social interactions to improve my own social skills.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I am always aware of the impression I make on other people.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I feel free to be myself when I am with other people.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 7 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 6 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 5 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 3 },
          { option_id: generateRandomUUID(), text: "Agree", score: 2 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 1 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I learn how people use their bodies and faces to interact by watching television or films, or by reading fiction.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I adjust my body language or facial expressions so that I appear relaxed.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "When talking to other people, I feel like the conversation flows naturally.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 7 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 6 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 5 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 3 },
          { option_id: generateRandomUUID(), text: "Agree", score: 2 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 1 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "I have spent time learning social skills from television shows and films, and try to use these in my interactions.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "In social interactions, I do not pay attention to what my face or body are doing.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 7 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 6 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 5 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 3 },
          { option_id: generateRandomUUID(), text: "Agree", score: 2 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 1 }
        ]
      },
      {
        question_id: generateRandomUUID(),
        text: "In social situations, I feel like I am pretending to be 'normal'.",
        options: [
          { option_id: generateRandomUUID(), text: "Strongly Disagree", score: 1 },
          { option_id: generateRandomUUID(), text: "Disagree", score: 2 },
          { option_id: generateRandomUUID(), text: "Somewhat Disagree", score: 3 },
          { option_id: generateRandomUUID(), text: "Neither Agree nor Disagree", score: 4 },
          { option_id: generateRandomUUID(), text: "Somewhat Agree", score: 5 },
          { option_id: generateRandomUUID(), text: "Agree", score: 6 },
          { option_id: generateRandomUUID(), text: "Strongly Agree", score: 7 }
        ]
      }
    ]
  }
];

function generateRandomUUID() {
  return uuidv4();
}

async function seedData() {
  try {
    const { data, error } = await supabase
      .from('assessments')
      .insert(assessments)
      .select();

    if (error) {
      console.error('Error inserting data:', error.message);
      return;
    }

    if (!data || data.length === 0) {
      console.log('No data returned from Supabase.');
      return;
    }

    console.log(`Successfully inserted ${data.length} records:`, data);
  } catch (err) {
    console.error('Unexpected error:', err.message);
  }
}

seedData();
