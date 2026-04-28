require(lme4)

# import data
d = jedi

# baseline model
baseline = lmer(darkness ~ 1 + (1 | dojo_id), data = d)
summary(baseline)

# fixed anger effect
fixed_anger = lmer(darkness ~ 1 + anger + (1 | dojo_id), data = d)
summary(fixed_anger)

# random + fixed  anger effect
fixed_random_anger = lmer(darkness ~ 1 + anger + (1 + anger | dojo_id), data = d)
summary(fixed_random_anger)

# question: do emotional attachments increase darkness, controlling for anger
model = lmer(darkness ~ anger + emotional_bonds +
               (anger + emotional_bonds | dojo_id ), data = d)
summary(model)

require(flexplot)
estimates(model)

visualize(model, plot = "model")
visualize(model, plot = "model",
          formula = darkness ~ emotional_bonds + dojo_id |anger)

visualize(model, plot = "model",
          formula = darkness ~ emotional_bonds + dojo_id, sample = 30)

visualize(model, plot = "model",
          formula = darkness ~ anger + dojo_id, sample = 30)

reduced = lmer(darkness ~ emotional_bonds + anger + (emotional_bonds | dojo_id), data = d)

compare.fits(darkness ~ anger | emotional_bonds + dojo_id, data = d, model1 = model, model2 = reduced, re = T)

model.comparison(model, reduced)

visualize(model, plot = "residuals")

visualize(model, plot = "model", formula = darkness ~ emotional_bonds + dojo_id, sample = 30)

visualize(model, plot = "model", formula = darkness ~ anger + dojo_id, sample = 30)
