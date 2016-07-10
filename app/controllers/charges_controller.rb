class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
        key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "Premium Membership - #{current_user.name}",
      amount: Amount.default
    }
  end

  def create
    #Creates a Stripe Customer object, for associating
    #with the charge
    customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
    )
    #The actual process
    charge = Stripe::Charge.create(
    customer: customer.id,
    amount: Amount.default,
    description: "Premium Membership for #{current_user.email}",
    currency: 'usd'
    )

    flash[:notice] = "Thanks for your purchase!, #{current_user.name}!"
    redirect_to root_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

end
