module ActiveScaffoldTests
	def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_new
    get :new
    assert_response :success
    assert_template 'create_form'
  end

  def test_edit
    get :edit, :id => @record.id
    assert_response :success
    assert_template 'update_form'
  end

  def test_show
    get :show, :id => @record.id
    assert_response :success
    assert_template 'show'
  end

  def test_should_create_record
    #given
    data = Factory.attributes_for(@record.class.to_s.underscore.to_sym)
    assert_difference("#{@record.class}.count") do
      #when
      post  :create, {"commit"=>"Create", :record=>data}
    end
    #then
    assert_not_nil  assigns("record")
  end

  def test_should_update
    #given
    attributes = Factory.attributes_for(@record.class.to_s.underscore.to_sym).shift
    data  = {attributes[0] => attributes[1]}

    assert_difference("#{@record.class}.count", 0) do
      #when
      put :update, {"commit"=>"Update",:id=>@record.id,
        :record=>data}
      #then
      # Assert that the record is not nil
      assert_not_nil  assigns("record")
      # Check that the update took place
      column = data.keys.first
      assert_equal  data[column], @record.class.find(@record.id).send(column)
    end
  end

  def test_should_delete
    #given
    id = @record.id
    assert_difference("#{@record.class}.count", -1) do
      #when
      delete  :destroy, :id => id
    end
  end
end
  