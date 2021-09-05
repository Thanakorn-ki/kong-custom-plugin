package main

import "github.com/Kong/go-pdk"

// Priority represent the last of processing each plugin
var Priority = -1000

//  Config represents the configure
type Config struct {
	Msg string
}

func New() interface{} {
	return &Config{}
}

func (c *Config) Access(kong *pdk.PDK) {
	kong.Log.Info("--------------------------- custom plugin ---------------------------")
	kong.Log.Debug(c.Msg)
	kong.ServiceRequest.SetHeader("x-kong-plugin", c.Msg)
}
