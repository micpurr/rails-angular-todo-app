module ApplicationHelper
	##
	##  helper for localize
	##
	def lc(word, transform_action='capitalize')
		I18n.t(word).send(transform_action)
	end

	##
	##  Current grid used bootstrap grid size
	##
	BOOTSTRAP_GRID_SIZE = 12 # or 16

	##
	##  helper for Calculate offset 
	##  and size for selected size
	##
	def get_col_size(grid_name, grid_value, offset)
		##
		##  Array for store styles
		##
		css = []

		##
		##  Set grid_value as BOOTSTRAP_GRID_SIZE if set nil value
		##
		grid_value = BOOTSTRAP_GRID_SIZE if grid_value.blank?

		##
		##  Create base size for grid
		##
		css << "col-#{grid_name}-#{grid_value}"

		##
		##  If grid_value have correct value 
		##  and offset is on then create offset size
		##  and add style to array
		##
		if grid_value <= (BOOTSTRAP_GRID_SIZE - 2) && offset
			css << "col-#{grid_name}-offset-#{(BOOTSTRAP_GRID_SIZE - grid_value)/2}"
		end

		##
		##  Conver array of styles to string and terurn it
		##
		css.join(" ")
	end

	##
	##  helper for creating css for form size
	##
	def form_size(size={}, offset=true)
		##
		##  Array for store styles
		##
		css = []

		##
		##  Default values for grid sizes
		##
		default_xs = size[:xs] || 12
		default_sm = size[:sm] || 12
		default_md = size[:md] || 10
		default_lg = size[:lg] || 8

		##
		##  Create grid sizes
		##
		css << get_col_size('xs', default_xs, offset)
		css << get_col_size('sm', default_sm, offset)
		css << get_col_size('md', default_md, offset)
		css << get_col_size('lg', default_lg, offset)

		##
		##  Conver array of styles to string and terurn it
		##
		css.join(" ")
	end
end
