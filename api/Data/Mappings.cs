using AutoMapper;
using api.Data.Entities;
using api.Data.DTOs.Authentication;

namespace api.Data.Mappings
{
    /// <summary>
    /// Automapper maps
    /// </summary>
    public partial class Maps : Profile
    {
        /// <summary>
        /// Constructor
        /// </summary>
        public Maps()
        {
            this.MappingEntity_ViewModel();
            this.MappingEntity_Model();
            this.CustomMapping();
        }

        private void MappingEntity_ViewModel()
        {
            CreateMap<User, UserProfileModel>().ReverseMap();
        }

        private void MappingEntity_Model()
        {

        }

        private void CustomMapping()
        {

        }
    }
}
