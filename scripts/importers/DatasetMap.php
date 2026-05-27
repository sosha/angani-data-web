<?php
/**
 * Phase 4 dataset routing map.
 *
 * Each entry maps either a global CSV filename or a country ZIP relative path
 * to the normalized Angani Data table and field mapping. Headers are matched
 * case-insensitively after normalization, so minor CSV header variations are OK.
 */
function phase4_dataset_groups(): array {
    return [
        'global' => [
            'description' => 'All root data/global CSV datasets with configured table mappings and raw-file logging.',
            'paths' => ['data/global/*.csv'],
        ],
        'country' => [
            'description' => 'Country ZIP folder imports: airlines, airports, commercial, infrastructure and regulatory datasets.',
            'paths' => ['data/countries/countries.zip'],
        ],
        'aircraft' => [
            'description' => 'Aircraft type/intelligence datasets: types, models, specs, engines, economics, cabin/payload and production history.',
            'filenames' => ['aircraft_types.csv','aircraft_data.csv','aircraft_assets.csv','cabin_payload.csv','economic_data.csv','engine_data.csv','environmental_data.csv','manufacturer_support.csv','operational_performance.csv','runway_requirements.csv','technical_specs.csv','history.csv','model_capacity.csv','model_specs.csv','models.csv','production.csv','sources.csv','lessors.csv'],
        ],
        'reference' => [
            'description' => 'Reference Data / Aviation Standards & Codes.',
            'filenames' => ['booking_class_hierarchy.csv','phonetic_alphabet.csv','country_codes.csv','passenger_terminal_codes.csv','meal_service_codes.csv','reject_reasons.csv','service_types.csv','licensing.csv'],
        ],
        'commercial' => [
            'description' => 'Commercial Intelligence: fares, inventory, rules, taxes/fees and yield analysis templates/snapshots.',
            'filenames' => ['fares.csv','fare_inventory.csv','fare_rules.csv','taxes_fees.csv','yield_analysis.csv'],
        ],
        'iata-iosa' => [
            'description' => 'IATA membership and IOSA registration reference/process tables.',
            'filenames' => ['iata_membership.csv','iosa_registration.csv'],
        ],
        'gds' => [
            'description' => 'Global Distribution Systems database.',
            'filenames' => ['global_distribution_systems.csv'],
        ],
        'infrastructure' => [
            'description' => 'Infrastructure/AIM: airport frequencies, navaids, NOTAM sources and country ZIP infrastructure files.',
            'filenames' => ['frequencies.csv','notam_sources.csv'],
            'country_paths_contains' => ['/Infrastructure/','/airports/frequencies.csv','/airports/runways.csv','/airports/terminals.csv','/airports/services.csv','/airports/hubs_and_airlines.csv'],
        ],
    ];
}

function phase4_global_map(): array {
    return [
        'aircraft_types.csv' => ['table'=>'aircraft_types','group'=>'aircraft','map'=>[
            'aircraft_type'=>'aircraft_type','common_name'=>'Common_Name','full_designation'=>'Full_Designation','manufacturer'=>'Manufacturer','model'=>'Model','iata_code'=>'IATA_Code','icao_code'=>'ICAO_Code','generation'=>'Generation','category'=>'Category','mission_type'=>'Mission_Type','wtc'=>'WTC','status'=>'Status'
        ], 'unique'=>['iata_code','icao_code','full_designation']],
        'aircraft_data.csv' => ['table'=>'aircraft_type_profile_data','group'=>'aircraft','map'=>[
            'aircraft_name'=>'Name','country_of_origin'=>'Country of Origin','aircraft_role'=>'Type','powerplants'=>'Powerplants','performance'=>'Performance','weights'=>'Weights','dimensions'=>'Dimensions','capacity'=>'Capacity','production'=>'Production','history'=>'History','source_url'=>'Source URL'
        ], 'unique'=>['aircraft_name']],
        'models.csv' => ['table'=>'aircraft_models','group'=>'aircraft','map'=>[
            'model_id'=>'Model_ID','model_name'=>'Name','origin'=>'Origin','role'=>'Role','iata_type_ref'=>'IATA_Type_Ref'
        ], 'unique'=>['model_id']],
        'history.csv' => ['table'=>'aircraft_model_history','group'=>'aircraft','map'=>[
            'model_id'=>'Model_ID','development_story'=>'Development_Story','milestones'=>'Milestones','status'=>'Status'
        ], 'unique'=>['model_id']],
        'model_capacity.csv' => ['table'=>'aircraft_model_capacity','group'=>'aircraft','map'=>[
            'model_id'=>'Model_ID','seating_config'=>'Seating_Config','cargo_vol'=>'Cargo_Vol','configurations'=>'Configurations'
        ], 'unique'=>['model_id']],
        'model_specs.csv' => ['table'=>'aircraft_model_specs','group'=>'aircraft','map'=>[
            'model_id'=>'Model_ID','powerplant_desc'=>'Powerplant_Desc','weights'=>'Weights','dimensions'=>'Dimensions','performance'=>'Performance'
        ], 'unique'=>['model_id']],
        'production.csv' => ['table'=>'aircraft_model_production','group'=>'aircraft','map'=>[
            'model_id'=>'Model_ID','units_built'=>'Units_Built','production_years'=>'Production_Years','price_usd'=>'Price_USD'
        ], 'unique'=>['model_id']],
        'sources.csv' => ['table'=>'aircraft_model_sources','group'=>'aircraft','map'=>[
            'model_id'=>'Model_ID','source_url'=>'Source_URL','bibliography'=>'Bibliography'
        ], 'unique'=>['model_id']],
        'aircraft_assets.csv' => ['table'=>'aircraft_type_assets','group'=>'aircraft','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','primary_livery_url'=>'Primary_Livery_URL','lopa_template_url'=>'LOPA_Template_URL','cockpit_reference_url'=>'Cockpit_Reference_URL'
        ], 'unique'=>['iata_code','icao_code']],
        'cabin_payload.csv' => ['table'=>'aircraft_type_cabin_payload','group'=>'aircraft','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','typical_c_seats'=>'Typical_C_Seats','typical_y_seats'=>'Typical_Y_Seats','max_capacity'=>'Max_Capacity','cargo_volume_m3'=>'Cargo_Volume (m3)','max_payload_kg'=>'Max_Payload (kg)'
        ], 'unique'=>['iata_code','icao_code']],
        'economic_data.csv' => ['table'=>'aircraft_type_economic_data','group'=>'aircraft','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','list_price_usd'=>'List_Price (USD)','op_cost_per_hour'=>'Op_Cost_per_Hour','lease_rate_monthly'=>'Lease_Rate_Monthly','residual_value_trend'=>'Residual_Value_Trend'
        ], 'unique'=>['iata_code','icao_code']],
        'engine_data.csv' => ['table'=>'aircraft_type_engine_data','group'=>'aircraft','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','engine_variants'=>'Engine_Variants','engine_type'=>'Engine_Type','engine_count'=>'Engine_Count','thrust_per_engine_kn'=>'Thrust_per_Engine (kN)','fuel_burn_rate'=>'Fuel_Burn_Rate','saf_compatible'=>'SAF_Compatible'
        ], 'unique'=>['iata_code','icao_code']],
        'environmental_data.csv' => ['table'=>'aircraft_type_environmental_data','group'=>'aircraft','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','carbon_intensity'=>'Carbon_Intensity','noise_chapter'=>'Noise_Chapter','fuel_type'=>'Fuel_Type'
        ], 'unique'=>['iata_code','icao_code']],
        'manufacturer_support.csv' => ['table'=>'aircraft_type_manufacturer_support','group'=>'aircraft','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','production_start'=>'Production_Start','production_end'=>'Production_End','total_built'=>'Total_Built','mro_availability'=>'MRO_Availability'
        ], 'unique'=>['iata_code','icao_code']],
        'operational_performance.csv' => ['table'=>'aircraft_type_operational_performance','group'=>'aircraft','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','max_range_nm'=>'Max_Range (nm)','service_ceiling_ft'=>'Service_Ceiling (ft)','v1'=>'V1','vr'=>'Vr','v2'=>'V2','vref'=>'Vref','cruise_speed_mach'=>'Cruise_Speed (Mach)','max_speed'=>'Max_Speed','climb_rate'=>'Climb_Rate'
        ], 'unique'=>['iata_code','icao_code']],
        'runway_requirements.csv' => ['table'=>'aircraft_type_runway_requirements','group'=>'aircraft','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','min_takeoff_length_ft'=>'Min_Takeoff_Length (ft)','min_landing_length_ft'=>'Min_Landing_Length (ft)','surface_compatibility'=>'Surface_Compatibility'
        ], 'unique'=>['iata_code','icao_code']],
        'technical_specs.csv' => ['table'=>'aircraft_type_technical_specs','group'=>'aircraft','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','mtow_kg'=>'MTOW (kg)','mzfw_kg'=>'MZFW (kg)','empty_weight_kg'=>'Empty_Weight (kg)','wingspan_m'=>'Wingspan (m)','length_m'=>'Length (m)','height_m'=>'Height (m)'
        ], 'unique'=>['iata_code','icao_code']],
        'lessors.csv' => ['table'=>'lessors','group'=>'aircraft','map'=>[
            'lessor_code'=>'Lessor_ID','name'=>'Name','hq_location'=>'HQ_Location','fleet_count'=>'Fleet_Size','contact_info'=>'Contact_Info','status'=>'Status'
        ], 'unique'=>['lessor_code','name']],

        'booking_class_hierarchy.csv' => ['table'=>'ref_booking_classes','group'=>'reference','map'=>[
            'category'=>'category','class_code'=>'class_code','description'=>'description','class_type'=>'type','rank_order'=>'rank'
        ], 'unique'=>['class_code','category']],
        'phonetic_alphabet.csv' => ['table'=>'ref_phonetic_alphabet','group'=>'reference','map'=>[
            'character_code'=>'character','phonetic'=>'phonetic'
        ], 'unique'=>['character_code']],
        'country_codes.csv' => ['table'=>'ref_country_codes','group'=>'reference','map'=>[
            'country_name'=>'country_name','alpha_2'=>'alpha_2','alpha_3'=>'alpha_3','numeric_code'=>'numeric_code','aircraft_prefix'=>'aircraft_prefix'
        ], 'unique'=>['alpha_2']],
        'passenger_terminal_codes.csv' => ['table'=>'ref_passenger_terminal_codes','group'=>'reference','map'=>[
            'code'=>'code','meaning'=>'meaning'
        ], 'unique'=>['code']],
        'meal_service_codes.csv' => ['table'=>'ref_meal_service_codes','group'=>'reference','map'=>[
            'code'=>'code','meaning'=>'meaning'
        ], 'unique'=>['code']],
        'reject_reasons.csv' => ['table'=>'ref_reject_reasons','group'=>'reference','map'=>[
            'reject_reason'=>'reject_reason'
        ]],
        'service_types.csv' => ['table'=>'ref_service_types','group'=>'reference','map'=>[
            'service_type_code'=>'service_type_code','application'=>'application','type_of_operation'=>'type_of_operation','service_type'=>'service_type','description'=>'description'
        ], 'unique'=>['service_type_code','application']],
        'licensing.csv' => ['table'=>'regulatory_licensing_categories','group'=>'reference','map'=>[
            'iso_country'=>'iso_country','category'=>'category','name'=>'name','validity'=>'validity','cost'=>'cost','requirements'=>'requirements','description'=>'description'
        ], 'unique'=>['iso_country','category','name']],

        'iata_membership.csv' => ['table'=>'iata_membership_requirements','group'=>'iata-iosa','map'=>[
            'section'=>'section','detail'=>'detail','description'=>'description'
        ], 'auto_order'=>true],
        'iosa_registration.csv' => ['table'=>'iosa_registration_steps','group'=>'iata-iosa','map'=>[
            'step'=>'step','action'=>'action','description'=>'description'
        ], 'auto_order'=>true],
        'global_distribution_systems.csv' => ['table'=>'gds_systems','group'=>'gds','map'=>[
            'gds_code'=>'Code','company'=>'Company','region'=>'Region','notes'=>'Notes'
        ], 'unique'=>['gds_code']],

        'frequencies.csv' => ['table'=>'airport_frequencies','group'=>'infrastructure','map'=>[
            'airport_ref'=>'airport_ref','airport_ident'=>'airport_ident','frequency_type'=>'type','description'=>'description','frequency_mhz'=>'frequency_mhz'
        ], 'unique'=>['airport_ident','frequency_type','frequency_mhz']],
        'notam_sources.csv' => ['table'=>'notam_sources','group'=>'infrastructure','map'=>[
            'iso_country'=>'iso_country','country_name'=>'country_name','official_source_name'=>'official_source_name','notam_portal_url'=>'notam_portal_url','icao_nof_code'=>'icao_nof_code','notes'=>'notes'
        ], 'unique'=>['iso_country','icao_nof_code']],

        'fares.csv' => ['table'=>'commercial_fares','group'=>'commercial','map'=>[
            'fare_id'=>'Fare_ID','airline_code'=>'Airline_Code','flight_number_schedule_id'=>'Flight_Number_Schedule_ID','origin_iata'=>'Origin_IATA','destination_iata'=>'Destination_IATA','date_seasonality'=>'Date_Seasonality','base_fare'=>'Base_Fare','total_fare'=>'Total_Fare'
        ], 'unique'=>['fare_id']],
        'fare_inventory.csv' => ['table'=>'commercial_fare_inventory','group'=>'commercial','map'=>[
            'fare_id'=>'Fare_ID','cabin_class'=>'Cabin_Class','fare_family'=>'Fare_Family','booking_class_code_rbd'=>'Booking_Class_Code_RBD','baggage_allowance'=>'Baggage_Allowance','ancillary_services'=>'Ancillary_Services'
        ], 'unique'=>['fare_id','booking_class_code_rbd']],
        'fare_rules.csv' => ['table'=>'commercial_fare_rules','group'=>'commercial','map'=>[
            'fare_id'=>'Fare_ID','refundability'=>'Refundability','change_fees'=>'Change_Fees','advance_purchase_requirement_days'=>'Advance_Purchase_Requirement_Days','min_stay'=>'Min_Stay','max_stay'=>'Max_Stay','blackout_dates_restrictions'=>'Blackout_Dates_Restrictions'
        ], 'unique'=>['fare_id']],
        'taxes_fees.csv' => ['table'=>'commercial_taxes_fees','group'=>'commercial','map'=>[
            'fare_id'=>'Fare_ID','surcharge_yq_yr'=>'Surcharge_YQ_YR','airport_taxes'=>'Airport_Taxes','government_taxes'=>'Government_Taxes','other_fees'=>'Other_Fees','total_taxes_fees'=>'Total_Taxes_Fees'
        ], 'unique'=>['fare_id']],
        'yield_analysis.csv' => ['table'=>'commercial_yield_analysis','group'=>'commercial','map'=>[
            'fare_id'=>'Fare_ID','yield_per_km_cpk'=>'Yield_Per_KM_CPK','revenue_per_passenger'=>'Revenue_Per_Passenger','load_factor_impact'=>'Load_Factor_Impact','competitor_benchmark'=>'Competitor_Benchmark','price_gap_vs_competitor'=>'Price_Gap_vs_Competitor'
        ], 'unique'=>['fare_id']],

        'airlines.csv' => ['table'=>'airlines','group'=>'global','map'=>[
            'name'=>'Airline','trading_name'=>'Trading_Name','iata_code'=>'IATA','icao_code'=>'ICAO','callsign'=>'Callsign','country_code'=>'Country','status'=>'Active','hubs'=>'Hubs','fleet_size'=>'Fleet Size','alliance'=>'Alliance','frequent_flyer_program'=>'Frequent Flyer Program','website_url'=>'Website','logo_url'=>'Logo','notes'=>'Comments'
        ], 'unique'=>['iata_code','icao_code','name']],
        'digital_properties.csv' => ['table'=>'airline_digital_properties','group'=>'global','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','airline_name'=>'Airline Name','category'=>'Category','platform'=>'Platform','description'=>'Description','url_or_handle'=>'URL or Handle','is_primary'=>'Is Primary'
        ]],
        'frequent_flyer_programs.csv' => ['table'=>'frequent_flyer_programs','group'=>'global','map'=>[
            'airline_name'=>'airline','airline_code'=>'airline_code','program_name'=>'program_name','points_unit'=>'points_unit','notes'=>'notes'
        ], 'unique'=>['airline_code','program_name']],
    ];
}

function phase4_country_map(): array {
    return [
        'airlines/airlines.csv' => ['table'=>'airlines','group'=>'country','map'=>[
            'name'=>'Airline','trading_name'=>'Trading_Name','iata_code'=>'IATA','icao_code'=>'ICAO','callsign'=>'Callsign','country_code'=>'Country'
        ], 'unique'=>['country_code','iata_code','icao_code','name']],
        'airlines/corporate_identity.csv' => ['table'=>'airlines','group'=>'country','update_table'=>'airlines','map'=>[
            'name'=>'Airline','legal_name'=>'Legal_Name','ceo_accountable_manager'=>'CEO_Accountable_Manager','parent_company'=>'Parent_Company','ownership_type'=>'Ownership_Type','status'=>'Trading_Status','notes'=>'Notes'
        ], 'unique'=>['country_code','name']],
        'airlines/digital_properties.csv' => ['table'=>'airline_digital_properties','group'=>'country','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','airline_name'=>'Airline Name','category'=>'Category','platform'=>'Platform','description'=>'Description','url_or_handle'=>'URL or Handle','is_primary'=>'Is Primary'
        ]],
        'airlines/brand_assets.csv' => ['table'=>'airline_brand_assets','group'=>'country','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','asset_category'=>'Asset Category','asset_name'=>'Asset Name','asset_value'=>'Value','description'=>'Description'
        ]],
        'airlines/fleet_list.csv' => ['table'=>'airline_fleet_list','group'=>'country','map'=>[
            'registration'=>'Registration','msn'=>'MSN','aircraft_model'=>'Aircraft_Model','aircraft_subtype'=>'Aircraft_Subtype','delivery_date'=>'Delivery_Date','operator_airline'=>'Operator_Airline','current_status'=>'Current_Status'
        ]],
        'airlines/fleet_summary.csv' => ['table'=>'airline_fleet_summary','group'=>'country','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','aircraft_type'=>'Aircraft Type','aircraft_count'=>'A/C Count','configuration_lopa'=>'Configuration (LOPA)','average_age'=>'Average Age','engine_type'=>'Engine Type'
        ]],
        'airlines/frequent_flyer_programs.csv' => ['table'=>'frequent_flyer_programs','group'=>'country','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','program_name'=>'Program Name','tier_level'=>'Tier Level','points_unit'=>'Points Currency','website_url'=>'Website'
        ]],
        'airlines/hubs.csv' => ['table'=>'airline_hubs','group'=>'country','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','airport_code'=>'Airport Code','hub_type'=>'Hub Type','region_served'=>'Region Served','description'=>'Description'
        ]],
        'airlines/operational_hubs.csv' => ['table'=>'airline_hubs','group'=>'country','map'=>[
            'airline_name'=>'Airline','airport_code'=>'Primary_Hub','description'=>'Secondary_Hubs','region_served'=>'Main_Base'
        ]],
        'airlines/it_infrastructure.csv' => ['table'=>'airline_it_infrastructure','group'=>'country','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','system_category'=>'System Category','system_name'=>'System Name','provider'=>'Provider','description'=>'Description'
        ]],
        'airlines/key_personnel.csv' => ['table'=>'airline_key_personnel','group'=>'country','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','person_name'=>'Name','title'=>'Title','category'=>'Category','email'=>'Email','phone'=>'Phone'
        ]],
        'airlines/operational_stats.csv' => ['table'=>'airline_operational_stats','group'=>'country','map'=>[
            'iata_code'=>'IATA','icao_code'=>'ICAO','stat_year'=>'Year','pax_count'=>'Pax Count','cargo_volume'=>'Cargo Volume','revenue'=>'Revenue','ebit'=>'EBIT','staff_count'=>'Staff Count'
        ]],
        'airports/airports.csv' => ['table'=>'airports','group'=>'country','map'=>[
            'icao_code'=>'ICAO','iata_code'=>'IATA','airport_name'=>'Name','trading_name'=>'Trading Name','airport_type'=>'Type','status'=>'Status','municipality'=>'Municipality','country_code'=>'Country','region_name'=>'Region','latitude'=>'Lat','longitude'=>'Lon','elevation_ft'=>'Elevation','ident'=>'Ident','callsign'=>'Callsign','founding_year'=>'Founding Year','introduction'=>'Introduction'
        ], 'unique'=>['icao_code','iata_code','airport_name']],
        'airports/digital_properties.csv' => ['table'=>'airport_digital_properties','group'=>'country','map'=>[
            'icao_code'=>'ICAO','iata_code'=>'IATA','category'=>'Category','platform'=>'Platform','url_or_handle'=>'URL/Handle','is_primary'=>'Is Primary'
        ]],
        'airports/financial_performance.csv' => ['table'=>'airport_financial_performance','group'=>'country','map'=>[
            'icao_code'=>'ICAO','iata_code'=>'IATA','stat_year'=>'Year','revenue'=>'Revenue','profit_loss'=>'Profit/Loss','investment'=>'Investment','staff_count'=>'Staff Count','ownership_structure'=>'Ownership Structure'
        ]],
        'airports/frequencies.csv' => ['table'=>'airport_frequencies','group'=>'country','map'=>[
            'icao_code'=>'ICAO','iata_code'=>'IATA','frequency_type'=>'Frequency Type','frequency_mhz'=>'Frequency','description'=>'Description'
        ]],
        'airports/ground_handling.csv' => ['table'=>'airport_ground_handling','group'=>'country','map'=>[
            'icao_code'=>'ICAO','iata_code'=>'IATA','company'=>'Company','categories'=>'Categories','contract_info'=>'Contract Info'
        ]],
        'airports/ground_transport.csv' => ['table'=>'airport_ground_transport','group'=>'country','map'=>[
            'icao_code'=>'ICAO','iata_code'=>'IATA','transport_mode'=>'Mode','provider'=>'Provider','link_description'=>'Link Description'
        ]],
        'airports/hubs_and_airlines.csv' => ['table'=>'airport_hubs_and_airlines','group'=>'country','map'=>[
            'icao_code'=>'ICAO','iata_code'=>'IATA','airline_name'=>'Airline Name','relation'=>'Relation','destinations_served'=>'Destinations Served'
        ]],
        'airports/it_infrastructure.csv' => ['table'=>'airport_it_infrastructure','group'=>'country','map'=>[
            'icao_code'=>'ICAO','iata_code'=>'IATA','category'=>'Category','system_name'=>'System Name','provider'=>'Provider','innovation_notes'=>'Innovation Notes'
        ]],
        'airports/key_personnel.csv' => ['table'=>'airport_key_personnel','group'=>'country','map'=>[
            'icao_code'=>'ICAO','iata_code'=>'IATA','person_name'=>'Name','title'=>'Title','category'=>'Category','contact'=>'Contact'
        ]],
        'airports/operational_stats.csv' => ['table'=>'airport_operational_stats','group'=>'country','map'=>[
            'icao_code'=>'ICAO','iata_code'=>'IATA','stat_year'=>'Year','pax_count'=>'Pax Count','cargo_tonnes'=>'Cargo Tonnes','movements'=>'Movements','slot_status'=>'Slot Status'
        ]],
        'airports/runways.csv' => ['table'=>'airport_runways','group'=>'country','map'=>[
            'icao_code'=>'ICAO','iata_code'=>'IATA','runway_ident'=>'ID','length_ft'=>'Length (ft)','width_ft'=>'Width (ft)','surface'=>'Surface','lighting'=>'Lighting','ils_frequency'=>'ILS Frequency'
        ]],
        'airports/services.csv' => ['table'=>'airport_services','group'=>'country','map'=>[
            'icao_code'=>'ICAO','iata_code'=>'IATA','service_category'=>'Service Category','provider'=>'Provider','description'=>'Description'
        ]],
        'airports/terminals.csv' => ['table'=>'airport_terminals','group'=>'country','map'=>[
            'icao_code'=>'ICAO','iata_code'=>'IATA','terminal_type'=>'Terminal Type','terminal_name'=>'Name','capacity'=>'Capacity','facilities'=>'Facilities','gates_count'=>'Gates Count'
        ]],
        'Commercial/fare_policy.csv' => ['table'=>'country_fare_policies','group'=>'country','map'=>[
            'carrier_code'=>'Carrier_Code','avg_domestic_yield'=>'Avg_Domestic_Yield','avg_intl_yield'=>'Avg_Intl_Yield','tax_policy'=>'Tax_Policy','currency_standard'=>'Currency_Standard'
        ]],
        'Infrastructure/navaids.csv' => ['table'=>'navaids','group'=>'infrastructure','map'=>[
            'source_navaid_id'=>'id','navaid_type'=>'NAVAID_Type','identifier_code'=>'Identifier_Code','navaid_name'=>'Name','latitude'=>'Latitude','longitude'=>'Longitude','elevation_ft'=>'Elevation','country_name'=>'Country','region_fir'=>'Region_FIR','chart_reference'=>'Chart_Reference'
        ], 'unique'=>['country_code','source_navaid_id']],
        'Infrastructure/navaids_technical.csv' => ['table'=>'navaid_technical','group'=>'infrastructure','map'=>[
            'source_navaid_id'=>'id','frequency'=>'Frequency','channel_number'=>'Channel_Number','morse_code'=>'Morse_Code','signal_type'=>'Signal_Type','power_output'=>'Power_Output','equipment_model'=>'Equipment_Model','redundancy_systems'=>'Redundancy_Systems'
        ], 'unique'=>['country_code','source_navaid_id']],
        'Infrastructure/navaids_operational.csv' => ['table'=>'navaid_operational','group'=>'infrastructure','map'=>[
            'source_navaid_id'=>'id','service_volume'=>'Service_Volume','range_nm'=>'Range_NM','mag_variation'=>'Mag_Variation','status'=>'Status','maintenance_authority'=>'Maintenance_Authority','date_commissioned'=>'Date_Commissioned','last_inspection'=>'Last_Inspection'
        ], 'unique'=>['country_code','source_navaid_id']],
        'Infrastructure/navaids_connectivity.csv' => ['table'=>'navaid_connectivity','group'=>'infrastructure','map'=>[
            'source_navaid_id'=>'id','associated_airports'=>'Associated_Airports','associated_airways'=>'Associated_Airways','system_integration'=>'System_Integration','interoperability_notes'=>'Interoperability_Notes'
        ], 'unique'=>['country_code','source_navaid_id']],
        'Infrastructure/navaids_references.csv' => ['table'=>'navaid_references','group'=>'infrastructure','map'=>[
            'source_navaid_id'=>'id','additional_notes'=>'Additional_Notes','data_sources'=>'Data_Sources'
        ], 'unique'=>['country_code','source_navaid_id']],
        'Infrastructure/NOTAMs/notams.csv' => ['table'=>'notams','group'=>'infrastructure','map'=>[
            'source_notam_id'=>'id','series_number'=>'Series_Number','notam_type'=>'NOTAM_Type','issuing_authority'=>'Issuing_Authority','summary'=>'Summary'
        ], 'unique'=>['country_code','source_notam_id']],
        'Infrastructure/NOTAMs/classification.csv' => ['table'=>'notam_classification','group'=>'infrastructure','map'=>[
            'source_notam_id'=>'id','subject_code'=>'Subject_Code','modifier_code'=>'Modifier_Code','traffic_code'=>'Traffic_Code','purpose_code'=>'Purpose_Code','scope'=>'Scope','issuing_nof'=>'Issuing_NOF'
        ]],
        'Infrastructure/NOTAMs/content.csv' => ['table'=>'notam_content','group'=>'infrastructure','map'=>[
            'source_notam_id'=>'id','raw_text'=>'Raw_Text','cleaned_text'=>'Cleaned_Text','flight_level_limits'=>'Flight_Level_Limits','affected_area_radius'=>'Affected_Area_Radius','restriction_type'=>'Restriction_Type'
        ]],
        'Infrastructure/NOTAMs/schedule.csv' => ['table'=>'notam_schedule','group'=>'infrastructure','map'=>[
            'source_notam_id'=>'id','start_utc'=>'Start_UTC','end_utc'=>'End_UTC','schedule_notes'=>'Schedule_Notes','perm_temp_flag'=>'Perm_Temp_Flag','date_issued'=>'Date_Issued'
        ]],
        'Infrastructure/NOTAMs/connectivity.csv' => ['table'=>'notam_connectivity','group'=>'infrastructure','map'=>[
            'source_notam_id'=>'id','associated_airports'=>'Associated_Airports','associated_navaids'=>'Associated_Navaids','associated_airways'=>'Associated_Airways','affected_procedures'=>'Affected_Procedures','interoperability_notes'=>'Interoperability_Notes'
        ]],
        'Infrastructure/NOTAMs/references.csv' => ['table'=>'notam_references','group'=>'infrastructure','map'=>[
            'source_notam_id'=>'id','additional_notes'=>'Additional_Notes','data_sources'=>'Data_Sources','replacement_reference'=>'Replacement_Reference'
        ]],
        'Regulatory/authority.csv' => ['table'=>'regulatory_authorities','group'=>'country','map'=>[
            'name'=>'Name','abbreviation'=>'Abbreviation','jurisdiction'=>'Jurisdiction','hq_location'=>'HQ_Location','founding_year'=>'Founding_Year','governance_structure'=>'Governance_Structure','key_officials'=>'Key_Officials','website'=>'Website','official_register_link'=>'Official_Register_Link','unofficial_register_link'=>'Unofficial_Register_Link'
        ]],
        'Regulatory/certification.csv' => ['table'=>'regulatory_records','group'=>'country','map'=>[
            'airline_icao'=>'ICAO','airline_iata'=>'IATA','type'=>'Cert Type','authority'=>'Authority','notes'=>'Notes'
        ]],
        'Regulatory/economic_licensing.csv' => ['table'=>'regulatory_economic_licensing','group'=>'country','map'=>[
            'license_types'=>'License_Types','foreign_ownership_limit'=>'Foreign_Ownership_Limit','cabotage_rights'=>'Cabotage_Rights','air_service_agreements'=>'Air_Service_Agreements','market_access_policies'=>'Market_Access_Policies'
        ]],
        'Regulatory/environmental_security.csv' => ['table'=>'regulatory_environmental_security','group'=>'country','map'=>[
            'corsia_status'=>'CORSIA_Status','emissions_programs'=>'Emissions_Programs','noise_regulations'=>'Noise_Regulations','security_program'=>'Security_Program','cybersecurity_oversight'=>'Cybersecurity_Oversight'
        ]],
        'Regulatory/licensing.csv' => ['table'=>'regulatory_licensing_categories','group'=>'country','map'=>[
            'iso_country'=>'iso_country','category'=>'category','name'=>'name','validity'=>'validity','cost'=>'cost','requirements'=>'requirements','description'=>'description'
        ]],
        'Regulatory/operational_certification.csv' => ['table'=>'regulatory_operational_certification','group'=>'country','map'=>[
            'aoc_registry'=>'AOC_Registry','authorized_aircraft'=>'Authorized_Aircraft','operational_limits'=>'Operational_Limits','amo_mro_approvals'=>'AMO_MRO_Approvals','ato_approvals'=>'ATO_Approvals','renewal_dates'=>'Renewal_Dates'
        ]],
        'Regulatory/references.csv' => ['table'=>'regulatory_references','group'=>'country','map'=>[
            'additional_notes'=>'Additional_Notes','data_sources'=>'Data_Sources','cross_links'=>'Cross_Links'
        ]],
        'Regulatory/safety_oversight.csv' => ['table'=>'regulatory_safety_oversight','group'=>'country','map'=>[
            'global_programs'=>'Global_Programs','usoap_scores'=>'USOAP_Scores','national_programs'=>'National_Programs','accident_authority'=>'Accident_Authority','icao_annexes'=>'ICAO_Annexes'
        ]],
    ];
}
