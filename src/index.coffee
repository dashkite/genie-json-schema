import * as M from "@dashkite/masonry"
import YAML from "js-yaml"
import Ajv from "ajv/dist/2020"

export default ( G ) ->
  
  options = G.get "schema"

  ajv = new Ajv allowUnionTypes: true

  G.define "schema:validate", M.start [
    M.glob options.glob
    M.read
    M.tr ({ input }) -> ajv.compile YAML.load input
  ]

  if !options.auto? || options.auto
    G.before "build", "schema:validate"


