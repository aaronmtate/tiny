# frozen_string_literal: true

# Clients should be able to create a shortened URL from a longer URL.
# Clients should be able to specify a custom slug.
# Clients should be able to expire / delete previous URLs.
# Users should be able to open the URL and get redirected.

class UrlAliasesController < ApplicationController
  before_action :clean_params

  def show
    url_alias = UrlAlias.latest_alias(params[:alias])
    redirect_to url_alias.url and return if url_alias.present?

    render json: { errors: "No URL found with alias \"#{params[:alias]}\"" }, status: :not_found
  end

  def claim
    url_alias = UrlAlias.new(params[:url], params[:alias])
    if url_alias.save
      render json: { message: "URL Alias \"#{url_alias.alias}\" claimed." }, status: :ok
    else
      render json: { error: url_alias.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def release
    url_alias = UrlAlias.active.find_by(alias: params[:alias])
    render json: { errors: "No active alias \"#{params[:alias]}\" to be released." }, status: :not_found and return if url_alias.blank?

    if url_alias.release
      render json: { message: "URL Alias \"#{url_alias.alias}\" released." }, status: :ok
    else
      render json: { error: url_alias.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  private

  def clean_params
    params[:alias] = params[:alias].gsub(/[0-9a-z]+/i, '') if params[:alias].present?
    params[:url] = params[:url].squish if params[:url].present?
  end
end
