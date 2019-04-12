#Analyze image
media = "https://i.ytimg.com/vi/DGU1awKrNiA/hqdefault.jpg"
params = {
  "requests":
  [
    {
      "features":
      [
        { "maxResults": 50, "type": "TEXT_DETECTION" },
      ],
      "image":
      {
        "source": { "imageUri": "#{media}" }
      },
    }
  ]
}
response = HTTParty.post(
  "https://vision.googleapis.com/v1/images:annotate?key={REPLACE_YOUR_API_KEY}",
  headers: { 'Content-Type' => 'application/json' },
  body: params.to_json
)
result[:analyzed] = response
result[:raw_text]=response["responses"].first["fullTextAnnotation"]["text"]
result[:sentences]=response["responses"].first["fullTextAnnotation"]["text"].split("\n")
result[:sentence]=response["responses"].first["fullTextAnnotation"]["text"].split("\n").join(" ")

#Classify
params = {
  "document":
  {
    "content": "#{result[:sentence]}",
    "type": "PLAIN_TEXT",
    "language": "pt-br"
  },
  "features":
  {
    "extractEntities": true
  }
}
response = HTTParty.post(
  "https://language.googleapis.com/v1/documents:annotateText?key=AIzaSyAi0QezwxaouYQVMhAre2kucrSY6lus5rU",
  headers: { 'Content-Type' => 'application/json' },
  body: params.to_json
)

result[:entities].each do |e|
  puts "#{e["name"]} : #{e["type"]}"
end

#output
BACK-END : CONSUMER_GOOD
parte : OTHER
DİZENDO : CONSUMER_GOOD
DE MEMORIA : OTHER
EM PROGRAMAÇÃO : CONSUMER_GOOD
6 : NUMBER
2 : NUMBER
