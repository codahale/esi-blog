# TODO: Make #esi_include automatically enable ESI on the controller?
module Esi::ViewHelper
  
  # Add an ESI include statement which, when processed by the ESI Surrogate,
  # will be replace with the contents of the resource at +src+. +src+ can be
  # a string or a <tt>#url_for</tt> hash (in which case the +src+ attribute
  # of the element will be generated with <tt>#url_for</tt>'s +:only_path+
  # option.
  # 
  # Possible keys for the +options+ hash:
  # 
  # :alt        An alternative URI to load from if +src+ is unavailable.
  # :onerror    If +continue+, no error will be raised by the ESI layer if +src+
  #             and +alt+ are unavailable or raise errors.
  # 
  # Examples:
  # 
  #   <%= esi_include(comment_url(comment1)) %>
  #   <%= esi_include("/ads?n=random", :onerror => :continue) %>
  #   <%= esi_include(:controller => "posts", :action => "show", :id => "1") %>
  def esi_include(src, options = {})
    if src.respond_to?(:update)
      options[:src] = url_for(src.update(:only_path => false))
    else
      options[:src] = src
    end
    options.assert_valid_keys(:src, :alt, :onerror)
    return tag("esi:include", options)
  end
  
end