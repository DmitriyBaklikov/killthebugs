module API
  module V1
    class FragmentsController < ApplicationController
      def create
        user = User.where(api_token: params[:api_token]).first

        if user.nil?
          head :unauthorized    # 401
          return
        end

        fragment = user.own_fragments.new params[:fragment]
        fragment.language ||= user.settings["default_language"]
        if fragment.save
          render text: fragment_path(fragment), status: :created # 201
        else
          head :not_acceptable  # 406
        end
      end
    end
  end
end
