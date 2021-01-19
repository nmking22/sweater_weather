require 'rails_helper'

describe 'munchie' do
  before :each do
    # create road trip
    json_data = File.read('spec/fixtures/weather_data.json')
    data = JSON.parse(json_data, symbolize_names: true)
    time = 260000
    @weather = WeatherAtEta.new(data, time)
    @trip = RoadTrip.new(time, 'denver,co', 'buffalo,ny', @weather)

    # create restaurant
    restaurant_data = {
      :id=>"kQxM1xlaZfQmXpKaqMTNnw",
      :alias=>"wonderful-bistro-pueblo",
      :name=>"Wonderful Bistro",
      :image_url=>
      "https://s3-media1.fl.yelpcdn.com/bphoto/EIPRzs68vSrQ_2tCf5pQNw/o.jpg",
      :is_closed=>false,
      :url=>
      "https://www.yelp.com/biz/wonderful-bistro-pueblo?adjust_creative=RfnJLc_PGB9Iz-8frxI0Xg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=RfnJLc_PGB9Iz-8frxI0Xg",
      :review_count=>64,
      :categories=>[{:alias=>"chinese", :title=>"Chinese"}],
      :rating=>4.0,
      :coordinates=>{:latitude=>38.319366, :longitude=>-104.616623},
      :transactions=>["delivery"],
      :price=>"$$",
      :location=>
        {:address1=>"4602 N Elizabeth St",
         :address2=>"Ste 120",
         :address3=>"",
         :city=>"Pueblo",
         :zip_code=>"81008",
         :country=>"US",
         :state=>"CO",
         :display_address=>
          ["4602 N Elizabeth St", "Ste 120", "Pueblo, CO 81008"]},
      :phone=>"+17195440233",
      :display_phone=>"(719) 544-0233",
      :distance=>6632.28027227077
    }

    @restaurant = Restaurant.new(restaurant_data)

  end

  it 'has readable attributes' do
    munchie = Munchie.new(@trip, @restaurant)

    expected_forecast = {
      :summary=>"broken clouds",
      :temperature=>"69"
    }

    expect(munchie.id).to eq('null')
    expect(munchie.destination_city).to eq('Buffalo, NY')
    expect(munchie.travel_time).to eq('3 day(s), 0 hour(s), 13 minute(s)')
    expect(munchie.forecast).to eq(expected_forecast)
    expect(munchie.restaurant).to eq(@restaurant)
  end

  describe 'instance methods' do
    it 'hash_forecast' do
      munchie = Munchie.new(@trip, @restaurant)

      expected_forecast = {
        :summary=>"broken clouds",
        :temperature=>"69"
      }

      expect(munchie.hash_forecast(@weather)).to eq(expected_forecast)
    end
  end
end
