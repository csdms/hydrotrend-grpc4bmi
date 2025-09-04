#include <stdio.h>

#include "hydrotrend/bmi_hydrotrend.h"
#include "bmi_grpc_server.h"


int main(int argc, char *argv[])
{
    printf("BmiHydrotrend grpc4bmi server\n");

    Bmi *model = (Bmi *) malloc(sizeof(Bmi));

    register_bmi_hydrotrend(model);

    {
        char model_name[BMI_MAX_COMPONENT_NAME];
        
        model->get_component_name(model, model_name);
        printf("%s\n", model_name);
    }

    run_bmi_server(model, argc, argv);

    free(model);
    return 0;
}
