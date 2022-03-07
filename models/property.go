package models

type PropertyRequest struct {
	ItemID string `json:"itemID"`
	DataSelector string `json:"dataSelector"`
	Postcode string `json:"postcode"`
	StreetName string `json:"streetName"`
	Creator string `json:"creator"`
}

type Property struct {
	ItemID string `json:"itemID"`
	DataSelector string `json:"dataSelector"`
	Postcode string `json:"postcode"`
	StreetName string `json:"streetName"`
	Creator string `json:"creator"`
}

type PropertyResponse struct {
	Properties []Property `json:"properties"`
	Error Error `json:"error"`
}

type Error struct {
	Message *string `json:"message"`
}