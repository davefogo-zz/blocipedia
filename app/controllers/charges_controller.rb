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
    begin
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

    rescue Stripe::CardError => e
      charge_error = e.message
    end

      if charge_error
        flash[:error] = "charge_error"
        render :new
      else
        current_user.premium!
        flash[:notice] = 'Thank you for your purchase!'
        redirect_to root_path
      end
    end
  end
