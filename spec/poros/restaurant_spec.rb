require 'rails_helper'

describe 'munchie' do
  before :each do
    @restaurant_data = {
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

    @restaurant = Restaurant.new(@restaurant_data)
  end

  it 'has readable attributes' do
    expect(@restaurant.address).to eq('4602 N Elizabeth St, Ste 120, Pueblo, CO 81008')
    expect(@restaurant.name).to eq('Wonderful Bistro')
  end

  describe 'instance methods' do
    it 'full_address' do
      address = @restaurant_data[:location]
      
      expect(@restaurant.full_address(address)).to eq('4602 N Elizabeth St, Ste 120, Pueblo, CO 81008')
    end
  end
end
