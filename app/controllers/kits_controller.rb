class KitsController < ApplicationController
  def XR250_XR400
  end

  def XR600
  end

  def XR650L
  end

  def replacement
    @replacement_products = Product.tagged_with(["Replacement"], any: true)
  end

  def rear_fenders_1
  end

  def rear_fenders_2
  end

  def graphics
  end
end
