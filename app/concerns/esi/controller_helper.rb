module Esi::ControllerHelper
  # Default options for Surrogate-Control headers.
  DEFAULT_ESI_OPTIONS = {
    :ttl              => 30.minutes,
    :stale_ttl        => false,
    :no_store         => false,
    :no_store_remote  => false,
    :content          => %{content="ESI/1.0"}
  }
  
  module ClassMethods
    def enable_esi(options = {})
      options         = options.reverse_merge(DEFAULT_ESI_OPTIONS)
      filter_options  = options.except(*DEFAULT_ESI_OPTIONS.keys)
      esi_options     = options.slice(*DEFAULT_ESI_OPTIONS.keys)
      after_filter(filter_options) do |controller|
        controller.send(:set_esi_headers, esi_options)
      end
    end
  end
  
  module InstanceMethods
    def set_esi_headers(options = {})
      esi_header = []

      if ttl = options[:ttl]
        maxage = "max-age=#{ttl.to_i}"
        if stale_ttl = options[:stale_ttl]
          maxage << "+#{stale_ttl.to_i}"
        end
        esi_header << maxage
      end

      esi_header << "no-store" if options[:no_store]
      esi_header << "no-store-remote" if options[:no_store_remote]
      esi_header << options[:content]

      headers["Surrogate-Control"] = esi_header.join(", ")
    end
  end
  
  def self.included(receiver)
    receiver.extend(ClassMethods)
    receiver.send(:include, InstanceMethods)
    receiver.send(:protected, :set_esi_headers)
  end
end