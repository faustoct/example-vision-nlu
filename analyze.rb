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
