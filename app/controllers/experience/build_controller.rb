class Experience::BuildController < ApplicationController
  include Wicked::Wizard

  steps *Experience.form_steps

  def show
    @experience = Experience.find(params[:experience_id])
    render_wizard
  end

  def update
  end
end
