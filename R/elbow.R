elbow <- function(data, plot = TRUE) {


  ## Argument checks ----

  if (missing(data)) {
    stop("Please provide a two-columns data frame.")
  }

  if (!is.list(data)) {
    stop("`data` must be a two-columns data frame.")
  }

  if (ncol(data) > 2) {
    warning("Only the first two columns will be considered.")
  }

  if (!is.numeric(data[ , 1]) || !is.numeric(data[ , 2])) {
    stop("Non-numeric data detected.")
  }

  if (sum(is.na(data[ , 1])) + sum(is.na(data[ , 2]))) {
    stop("Missing values detected.")
  }

  if (!is.logical(plot)) {
    stop("`plot` must be a boolean.")
  }


  ## Data transformation ----

  data <- data[ , 1:2]
  data <- data[order(data[ , 1]), ]


  ## Get constant increase/decrease in y ----

  constant <- data[c(1, nrow(data)), ]
  colnames(constant) <- c("x", "y")

  mod <- stats::lm(y ~ x, data = constant)

  data[ , "constant"] <- round(mod$coef[[1]] + mod$coef[[2]] * data[ , 1], 3)


  ## Detect inflection point ----

  pos <- round(nrow(data) / 2)

  if (data[pos, "constant"] < data[pos, 2]) { # Concave Down

    data[ , "benefits"] <- round(data[ , 2] - data[ , "constant"], 3)
    maxi <- data[which.max(data[ , "benefits"]), ]

  } else { # Concave Up

    ymax <- max(data[ , 2])
    data[ , "benefits"] <- ymax - round(data[ , "constant"] - data[ , 2], 3)
    maxi <- data[which.min(data[ , "benefits"]), ]
  }


  ## Store results ----

  xxx <- list()
  xxx[[1]] <- maxi[1, 1]
  xxx[[2]] <- data
  names(xxx) <- c(paste(colnames(data)[1], "selected", sep = "_"), "data")


  ## Plot ----

  if (plot) {

    xlims <- range(data[ , 1])
    ylims <- c(min(c(data[ , 2], data[ , 3], data[ , 4])), max(data[ , 2]))


    ## Graphical parameters ----

    graphics::par(
      mar      = c(2.5, 2.5, 1.5, 1.5),
      family   = "serif",
      cex.axis = 0.85,
      mgp      = c(2, .15, 0),
      tcl      = -0.25,
      fg       = "#666666",
      col      = "#666666",
      col.axis = "#666666"
    )


    ## Background plot ----

    graphics::plot(
      x    = data[ , 1],
      y    = data[ , 2],
      xlim = xlims,
      ylim = ylims,
      ann  = FALSE,
      axes = FALSE,
      type = "n"
    )

    graphics::grid()
    graphics::box()


    ## Add axes ----

    graphics::par(mgp = c(2, 0.00, 0))
    graphics::axis(1, lwd = 0)
    graphics::axis(1, maxi[ , 1], lwd = 0, font = 2, col.axis = "black")

    graphics::par(mgp = c(2, 0.25, 0))
    graphics::axis(2, lwd = 0, las = 1)
    at <- round(maxi[ , 2], 3)
    graphics::axis(2, at, lwd = 0, font = 2, col.axis = "black", las = 1)

    graphics::mtext(side = 1, cex = 1, line = 1.25, text = expression("x"))
    graphics::mtext(side = 2, cex = 1, line = 1.45, text = expression("f(x)"))


    ## Real gains/losses in y while x increases ----

    graphics::polygon(
      x      = c(data[ , 1], data[1, 1]),
      y      = c(data[ , "benefits"], data[1, "benefits"]),
      col    = "#aaaaaa66",
      border = "#aaaaaa"
    )


    ## Data serie ----

    graphics::points(
      x    = data[ , 1],
      y    = data[ , 2],
      type = "b",
      pch  = 19,
      col  = "black"
    )


    ## Inflection point informations ----

    graphics::lines(
      x   = rep(maxi[1, 1], 2),
      y   = c(par()$usr[3], maxi[1, 2]),
      col = "black",
      lwd = 0.5
    )

    graphics::lines(
      x   = c(par()$usr[1], maxi[1, 1]),
      y   = rep(maxi[1, 2], 2),
      col = "black",
      lwd = 0.5
    )

    graphics::points(
      x    = maxi[ , 1],
      y    = maxi[ , 2],
      type = "b",
      pch  = 19,
      cex  = 1.5,
      col  = "black"
    )

    graphics::points(
      x    = maxi[ , 1],
      y    = maxi[ , 4],
      type = "b",
      pch  = 19,
      cex  = 1,
      col  = "#666666"
    )
  }

  return(xxx)
}
