#' @title A list of pre-made shapefiles for \code{basemap}
#' @description Lists available pre-made shapefiles for plotting in the \code{\link{basemap}} function. Gives also instructions how to make custom ones.
#' @param name A character argument giving the name of a pre-made shapefile. Will be partially matched. Use "all" to list all available ones.
#' @param get.data Logical indicating whether spatial data should be returned instead of names of spatial data objects.
#' @details Custom shapefiles for \code{\link{basemap}} should be defined as lists with (at least) following names (everything should be provided as characters):
#' \itemize{
#' \item \strong{land} Object name of the \code{\link[sp]{SpatialPolygonsDataFrame}} containing land. Required.
#' \item \strong{glacier} Object name of the \code{\link[sp]{SpatialPolygonsDataFrame}} containing glaciers. Use \code{NULL} if glaciers are not needed.
#' \item \strong{bathy} Object name of the \code{\link[sp]{SpatialPolygonsDataFrame}} containing bathymetry contours. Use \code{NULL} if bathymetry is not needed.
#' }
#'
#' All linked spatial data objects must be in same projection. Pre-made shapefiles contain additional elements that are used in the \code{\link{basemap}} function, but not required for custom shapefile datasets.
#'
#' @return Returns a data frame of provided pre-made shapefiles, if \code{name = "all"}. Returns a shapefile list containing the information for a particular map otherwise.
#' @family basemap functions
#' @keywords shapefiles
#' @author Mikko Vihtakari
#' @examples
#' shapefile_list("all")
#' shapefile_list("Arctic") # partial matching
#' @export

shapefile_list <- function(name, get.data = FALSE) {

  # List of alternatives

  alternatives <- list(
    list(name = "ArcticStereographic", land = "arctic_land", glacier = "arctic_glacier", bathy = "arctic_bathy", crs = 3995),
    list(name = "AntarcticStereographic", land = "antarctic_land", glacier = "antarctic_glacier", bathy = "antarctic_bathy", crs = 3031),
    list(name = "DecimalDegree", land = "dd_land", glacier = "dd_glacier", bathy = "dd_bathy", crs = 4326)
  )

  names(alternatives) <- sapply(alternatives, function(k) k$name)

  # Return

  if(name == "all") {
    
    out <- do.call(rbind, lapply(alternatives, function(k) data.frame(k, stringsAsFactors = FALSE)))
    rownames(out) <- 1:nrow(out)
    
  } else  {
    out <- alternatives[[match.arg(name, names(alternatives))]] # Allows partial matching (typos likely in name)

    if(get.data) {
      out[c("land", "glacier", "bathy")] <- lapply(out[c("land", "glacier", "bathy")], function(k) get(k))
    }
  }
  
  out
}

