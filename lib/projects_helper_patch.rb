module ProjectsHelperPatch
    def self.included(base)
    	base.send(:include, InstanceMethods)
	    base.class_eval do
        alias_method :project_settings_tabs_without_template, :project_settings_tabs
        alias_method :project_settings_tabs, :project_settings_tabs_with_template
	    end
    end

module InstanceMethods
  def project_settings_tabs_with_template
    tabs = project_settings_tabs_without_template
    tabs.push({:name => 'template', :action => :view_templates, :partial => 'projects/settings/templates', :label => :label_template})
    tabs.select {|tab| User.current.allowed_to?(tab[:action], @project)}
  end
end

end
