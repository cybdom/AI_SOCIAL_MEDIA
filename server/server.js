
var cron = require('node-cron');
require('dotenv').config() 
const axios = require('axios');

const { initializeApp, applicationDefault, cert } = require('firebase-admin/app');
const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore')



const { Configuration, OpenAIApi } = require("openai");
const configuration = new Configuration({
    organization: "CHANGE_ME",
    apiKey: process.env.CHATGPT_KEY,
});
const openai = new OpenAIApi(configuration);

const serviceAccount = require('./CHANGE_ME.json');

initializeApp({
  credential: cert(serviceAccount)
});

const db = getFirestore();



cron.schedule('*/10 * * * * *', () => {
    (async () => {
    
        const contentResp = await openai.createCompletion({
            model: "text-davinci-003",
            prompt: "Human: Write an engaging tweet.\n",
            temperature: 0.9,
            max_tokens: 150,
            top_p: 1,
            frequency_penalty: 0,
            presence_penalty: 0.6,
            stop: [" Human:", " AI:"],
          });
      
    const usrResp = await axios.get('https://randomuser.me/api/');
    const usr = usrResp.data.results[0];
        const randomImgId = Math.floor(
            Math.random() * (1084 - 1) + 1
        );
        
       db.collection('feed').add({
            username : usr.login.username,
            userPic : usr.picture.medium,
            numLikes : 0,
            numComments: 0,
            date : Date.now(),
            content :contentResp.data.choices[0].text,
            imgUrl : "https://picsum.photos/id/" + randomImgId + "/800/800"
            }) 
    })()
});