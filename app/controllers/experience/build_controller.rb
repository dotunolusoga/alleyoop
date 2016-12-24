class Experience::BuildController < ApplicationController
  include Wicked::Wizard

  build *Experience.form_steps

  def show
  end

  def update
  end
end
